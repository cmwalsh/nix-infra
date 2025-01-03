{
  image = "ghcr.io/home-assistant/home-assistant:stable";
  hostname = "homeassistant";
  autoStart = true;

  ports = [
    "8123:8123"
  ];

  volumes = [
    "/mnt/ironwolf/appdata/homeassistant:/config"
    "/etc/localtime:/etc/localtime:ro"
    "/run/dbus:/run/dbus:ro"
  ];
}
