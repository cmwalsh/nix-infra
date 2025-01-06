{
  image = "docker.io/jellyfin/jellyfin:latest";
  hostname = "jellyfin";
  autoStart = true;

  environment = {
    JELLYFIN_PublishedServerUrl = "https://media.cwbt.uk";
  };

  ports = [
    "8096:8096/tcp"
  ];

  volumes = [
    "/mnt/ironwolf/appdata/jellyfin/config:/config"
    "/mnt/ironwolf/appdata/jellyfin/cache:/cache"
  ];

  extraOptions = [
    "--group-add=303"
    "--device=/dev/dri/renderD128:/dev/dri/renderD128"
    "--mount=type=bind,source=/mnt/ironwolf/media,destination=/media,ro=true,relabel=private"
  ];
}
