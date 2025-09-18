{ pkgs, ... }:

{
  services.greetd = {
    enable = true;

    regreet = {
      enable = true;
      
      settings = {
        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };
      };
    };
  };
}

