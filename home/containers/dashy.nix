{ inputs, ... }:

{
  imports = [
    inputs.quadlet-nix.homeManagerModules.quadlet
  ];

  virtualisation.quadlet = {
    containers = {
      dashy = {
        containerConfig = {
          image = "docker.io/lissy93/dashy:latest";
          name = "dashy";

          publishPorts = [
            "8080:8080"
          ];
        };

        serviceConfig = {
          RestartSec = "10";
          Restart = "always";
        };
      };
    };
  };
}
