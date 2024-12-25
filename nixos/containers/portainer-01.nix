{ ... }: {

  virtualisation.oci-containers.containers = {
    portainer = {
      image = "ghcr.io/portainer/portainer-ce:2.21.5";
      hostname = "Portainer 01";
      autoStart = true;

      ports = [
        "8000:8000"
        "9443:9443"
      ];

      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/mnt/ironwolf/appdata/portainer:/data"
      ];
    };
  };
}
