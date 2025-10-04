{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    enableTCPIP = true;

    ensureDatabases = [
      "mealie"
    ];

    ensureUsers = [
      {
        name = "mealie";
        ensureDBOwnership = true;
      }
    ];

    authentication = pkgs.lib.mkOverride 10 ''
      #type   database  DBuser  auth-method
      local   all       all     trust
      host    sameuser  all     127.0.0.1/32          scram-sha-256
      host    sameuser  all     ::1/128               scram-sha-256
      host    sameuser  all     192.168.0.0/16        scram-sha-256
    '';
  };
}

## Open a PSQL shell to the database
# sudo -u postgres psql <database>
