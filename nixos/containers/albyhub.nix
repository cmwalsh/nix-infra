{
  image = "ghcr.io/getalby/hub:latest";
  hostname = "albyhub";
  autoStart = true;

  environment = {
    WORK_DIR = "/data/albyhub";
    LOG_EVENTS = "true";
  };

  ports = [
    "8080:8080"
  ];

  volumes = [
    "/mnt/ironwolf/appdata/albyhub:/data"
  ];
}
