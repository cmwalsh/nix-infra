{ inputs, ... }:

{
  imports = [
    inputs.quadlet-nix.nixosModules.quadlet
  ];

  virtualisation.quadlet = {
    volumes = {
      omada-data = { };
      omada-logs = { };
    };

    containers = {
      omada-controller = {
        containerConfig = {
          image = "docker.io/mbentley/omada-controller:5";
          name = "omada-controller";

          ulimits = [
            "nofile=4096:8192"
          ];

          networks = [
            "host"
          ];

          volumes = [
            "omada-data:/opt/tplink/EAPController/data"
            "omada-logs:/opt/tplink/EAPController/logs"
          ];
        };

        serviceConfig = {
          RestartSec = "10";
          Restart = "always";
        };
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      8088
      8043
      8843
    ];

    allowedTCPPortRanges = [
      {
        from = 29811;
        to = 29817;
      }
    ];

    allowedUDPPorts = [
      19810
      27001
      29810
    ];
  };
}
