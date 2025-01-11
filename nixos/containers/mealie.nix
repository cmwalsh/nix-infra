{
  image = "ghcr.io/mealie-recipes/mealie:v2.4.2";
  hostname = "mealie";
  autoStart = true;

  environment = {
    ALLOW_SIGNUP = "false";
    TZ = "Europe/London";
    BASE_URL = "http://firefly.wolf-centauri.ts.net";
    TLS_CERTIFICATE_PATH = "/home/sysadmin/firefly.wolf-centauri.ts.net.crt";
    TLS_PRIVATE_KEY_PATH = "/home/sysadmin/firefly.wolf-centauri.ts.net.key";
  };

  ports = [
    "9925:9000"
  ];

  volumes = [
    "/mnt/ironwolf/appdata/mealie:/app/data"
  ];
}
