{...}: {
  virtualisation.oci-containers.containers = {
    home-assistant = {
      image = "ghcr.io/home-assistant/home-assistant:stable";
      hostname = "automata";
      autoStart = true;

      environment = {
        TZ = "Europe/London";
      };

      volumes = [
        "/mnt/ironwolf/appdata/home-assistant:/config"
        "/etc/localtime:/etc/localtime:ro"
        "/run/dbus:/run/dbus:ro"
      ];

      extraOptions = [
        "--device=/dev/ttyUSB0"
        "--network=host"
        "--privileged"
      ];
    };
  };
}
