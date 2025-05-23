{ ... }: {

  services.postgresql = {
    enable = true;
    enableTCPIP = true; # Port 5432

    ensureDatabases = [
      "churchman"
    ];

    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all     trust
      # ... other auth rules ...

      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host  all      all     ::1/128        trust
    '';

    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE churchman WITH LOGIN PASSWORD 'churchman' CREATEDB;
      CREATE DATABASE churchman;
      GRANT ALL PRIVILEGES ON DATABASE churchman TO churchman;
    '';
  };
}
