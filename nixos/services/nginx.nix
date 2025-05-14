{ config, ... }: {

  services.nginx = {
    enable = true;

    virtualHosts = {
      "media.cwbt.uk" = {
        forceSSL = true;
        useACMEHost = "cwbt.uk";
        locations."/".proxyPass = "http://100.68.27.20:8096";
      };
    };
  };
}
