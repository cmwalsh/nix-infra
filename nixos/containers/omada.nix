{ inputs, ... }:

{
  imports = [
    inputs.quadlet-nix.nixosModules.quadlet
  ];

  virtualisation.quadlet = {
    volumes = {
      omada-data = {};
      omada-logs = {};
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

          # publishPorts = [
          #   "8088:8088"
          #   "8043:8043"
          #   "27001:27001"
          #   "29810:29810"
          #   "29811:29811"
          #   "29812:29812"
          #   "29813:29813"
          #   "29814:29814"
          #   "29815:29815"
          #   "29816:29816"
          #   "29817:29817"
          # ];

          volumes = [
            "omada-data:/opt/tplink/EAPController/data"
            "omada-logs:/opt/tplink/EAPController/logs"
          ];

          # environments = {
          #   PUID = "508";
          #   PGID = "508";
          #   MANAGE_HTTP_PORT = "8088";
          #   MANAGE_HTTPS_PORT = "8043";
          #   PORTAL_HTTP_PORT = "8088";
          #   PORTAL_HTTPS_PORT = "8843";
          #   PORT_APP_DISCOVERY = "27001";
          #   PORT_DISCOVERY = "29810";
          #   PORT_MANAGER_V1 = "29811";
          #   PORT_ADOPT_V1 = "29812";
          #   PORT_UPGRADE_V1 = "29813";
          #   PORT_MANAGER_V2 = "29814";
          #   PORT_TRANSFER_V2 = "29815";
          #   PORT_RTTY = "29816";
          #   PORT_DEVICE_MONITOR = "29817";
          #   SHOW_SERVER_LOGS = "true";
          #   SHOW_MONGODB_LOGS = "false";
          #   TZ = "Europe/London";
          # };
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
      { from = 29811; to = 29817; }
    ];

    allowedUDPPorts = [
      19810
      27001
      29810
    ];
  };
}
