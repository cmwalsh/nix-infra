{ inputs, ... }:

{
  imports = [
    inputs.quadlet-nix.homeManagerModules.quadlet
  ];

  virtualisation.quadlet = {
    volumes = {
      mealiee-data = {
        autoStart = true;
      };
    };

    containers = {
      mealie = {
        autoStart = true;

        containerConfig = {
          image = "ghcr.io/mealie-recipes/mealie:v3.3.1";
          name = "mealie";

          publishPorts = [
            "9000:9000"
          ];

          volumes = [
            "mealie-data:/app/data/"
          ];

          environments = {
            ALLOW_SIGNUP = "false";
            PUID = "1000";
            PGID = "1000";
            TZ = "Europe/London";
            BASE_URL = "https://mealie.cwbt.uk";
          };
        };
      };
    };
  };
}
