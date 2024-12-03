{...}: {
  virtualisation.oci-containers.containers = {
    omada = {
      image = "mbentley/omada-controller:5.14";
      hostname = "omada-controller";
      autoStart = true;

      ports = [
        "8088:8088"
        # "8043:8043"
        # "8843:8843"
        "27001:27001/udp"
        "29810:29810/udp"
        "29811-29816:29811-29816"
      ];

      volumes = [
        "/mnt/ironwolf/appdata/omada/data:/opt/tplink/EAPController/data"
        "/mnt/ironwolf/appdata/omada/logs:/opt/tplink/EAPController/logs"
      ];

      environment = {
        TZ = "Europe/London";
        MANAGE_HTTP_PORT = "8088";
        # MANAGE_HTTPS_PORT = "8043";
        PGID = "508";
        PORTAL_HTTP_PORT = "8088";
        # PORTAL_HTTPS_PORT = "8843";
        PORT_ADOPT_V1 = "29812";
        PORT_APP_DISCOVERY = "27001";
        PORT_DISCOVERY = "29810";
        PORT_MANAGER_V1 = "29811";
        PORT_MANAGER_V2 = "29814";
        PORT_TRANSFER_V2 = "29815";
        PORT_RTTY = "29816";
        PORT_UPGRADE_V1 = "29813";
        PUID = "508";
      };

      extraOptions = [
        "--stop-timeout 60"
        "--ulimit nofile=4096:8192"
      ];
    };
  };
}
