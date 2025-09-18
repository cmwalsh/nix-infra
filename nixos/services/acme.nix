{ ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@cwbt.uk";

    certs."cwbt.uk" = {
      domain = "cwbt.uk";
      extraDomainNames = [ "*.cwbt.uk" ];
      dnsProvider = "hetzner";
      dnsPropagationCheck = true;
      environmentFile = /run/secrets/hetzner;
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
