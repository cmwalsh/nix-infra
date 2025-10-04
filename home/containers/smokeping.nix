{ inputs, ... }:

{
  imports = [
    inputs.quadlet-nix.homeManagerModules.quadlet
  ];

  virtualisation.quadlet = {
    volumes = {
      smokeping-config = {};
      smokeping-data = {};
    };

    containers = {
      smokeping = {
        containerConfig = {
          image = "lscr.io/linuxserver/smokeping:latest";
          name = "smokeping";

          publishPorts = [
            "8080:80"
          ];

          volumes = [
            "smokeping-config:/config"
            "smokeping-data:/data"
          ];

          environments = {
            PUID = "1003";
            PGID = "100";
            TZ = "Europe/London";
          };
        };

        serviceConfig = {
          RestartSec = "10";
          Restart = "always";
        };
      };
    };
  };
}
