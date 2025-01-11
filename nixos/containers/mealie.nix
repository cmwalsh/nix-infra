{
  image = "ghcr.io/mealie-recipes/mealie:v2.4.2";
  hostname = "mealie";
  autoStart = true;

  environment = {
    ALLOW_SIGNUP = "false";
    TZ = "Europe/London";
  };

  ports = [
    "9925:9000"
  ];

  volumes = [
    "/mnt/ironwolf/appdata/mealie:/app/data"
  ];
}
