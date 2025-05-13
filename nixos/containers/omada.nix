{ ... }: {

  virtualisation.oci-containers.containers = {
    omada-controller = {
      image = "docker.io/mbentley/omada-controller:5.15";
      hostname = "omada";
      autoStart = true;

      environment = {
        TZ = "Europe/London";
        PUID = "508";
        PGID = "508";
        MANAGE_HTTP_PORT = "8088";
        MANAGE_HTTPS_PORT = "8043";
        PORTAL_HTTP_PORT = "8088";
        PORTAL_HTTPS_PORT = "8843";
        PORT_ADOPT_V1 = "29812";
        PORT_APP_DISCOVERY = "27001";
        PORT_DISCOVERY = "29810";
        PORT_MANAGER_V1 = "29811";
        PORT_MANAGER_V2 = "29814";
        PORT_TRANSFER_V2 = "29815";
        PORT_RTTY = "29816";
        PORT_UPGRADE_V1 = "29813";
        SHOW_SERVER_LOGS = "true";
        SHOW_MONGODB_LOGS = "false";
      };
      
      ports = [ 
        "8088:8088"
        "8043:8043"
        "8843:8843"
        "27001:27001/udp"
        "29810:29810/udp"
        "29811-29816:29811-29816"
      ];

      volumes = [
        "/home/sysadmin/containers/omada/data:/opt/tplink/EAPController/data"
        "/home/sysadmin/containers/omada/logs:/opt/tplink/EAPController/logs"
      ];
    };
  };

  # Ensure container volume directories exist
  systemd.tmpfiles.rules = [
    "d /home/sysadmin/containers/omada 0744 sysadmin users -"
    "d /home/sysadmin/containers/omada/data 0744 sysadmin users -"
    "d /home/sysadmin/containers/omada/logs 0744 sysadmin users -"
  ];

  # Allow containers ports
  networking.firewall.allowedTCPPorts = [ 8088 8043 8843 ];
  networking.firewall.allowedTCPPortRanges = [{ from = 29811; to = 29816; }];
  networking.firewall.allowedUDPPorts = [ 27001 29811 ];
}
