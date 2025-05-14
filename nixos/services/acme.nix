{ ... }: {

  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@cwbt.uk";

    certs."cwbt.uk" = {
      domain = "cwbt.uk";
      extraDomainName = [ "*.cwbt.uk" ];
      dnsProvider = "route53";
      dnsPropagationCheck = true;
      credentialsFile = /run/secrets-rendered/route53-env;
    };
  };
}
