{...}: {
  virtualisation.oci-containers.containers = {
    albyhub = {
      image = "ghcr.io/getalby/hub:latest";
      hostname = "albyhub";
      autoStart = true;

      ports = [
        "8080:8080"
      ];

      volumes = [
        "/mnt/ironwolf/appdata/albyhub/data:/data"
      ];

      environment = {
        WORK_DIR = "/data";
        LOG_EVENTS = true;
      };
    };
  };
}
