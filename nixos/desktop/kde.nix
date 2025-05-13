{ pkgs, ... }: {

  # KDE 6
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # disable KDE indexer because it's preventing sleep
  # https://github.com/NixOS/nixpkgs/issues/63489
  environment = {
    etc."xdg/baloofilerc".source = (pkgs.formats.ini {}).generate "baloorc" {
      "Basic Settings" = {
        "Indexing-Enabled" = false;
      };
    };
  };

  # KDE Partition Manager
  programs = {
    partition-manager.enable = true;
  };

  # Useful KDE packages
  environment.systemPackages = with pkgs; [
    kdePackages.isoimagewriter
    kdePackages.kcalc
    kdePackages.filelight
    kdePackages.sddm-kcm
    onlyoffice-desktopeditors
  ];
}
