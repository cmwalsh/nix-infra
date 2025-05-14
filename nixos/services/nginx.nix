{ config, ... }: {

  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@cwbt.uk";

    certs."cwbt.uk" = {
      domain = "cwbt.uk";
      extraDomainNames = [ "*.cwbt.uk" ];
      dnsProvider = "route53";
      dnsPropagationCheck = true;
      environmentFile = /run/secrets/route53-env;
    };
  };

  services.nginx = {
    enable = true;

    virtualHosts = {
      # Jellyfin
      "media.cwbt.uk" = {
        forceSSL = true;
        useACMEHost = "cwbt.uk";
        locations."/".proxyPass = "http://100.68.27.20:8096";
      };

      # Home Assistant
      "ha.cwbt.uk" = {
        forceSSL = true;
        useACMEHost = "cwbt.uk";
        locations."/".proxyPass = "http://100.68.27.20:8123";
      };
    };
  };
}
