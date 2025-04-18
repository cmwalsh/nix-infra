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

  # Xserver
  services.xserver = {
    enable = true;

    # X11 keymap
    xkb = {
      layout = "gb";
      variant = "";
    };

    # Disable xterm
    excludePackages = [pkgs.xterm];
    desktopManager.xterm.enable = false;
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # Enable OpenCL
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  # KDE Partition Manager
  programs = {
    partition-manager.enable = true;
  };

  # Use the correct file picker on KDE
  programs.firefox.preferences = {
    "widget.use-xdg-desktop-portal.file-picker" = 1;
  };

  # Useful KDE packages
  environment.systemPackages = with pkgs; [
    kdePackages.isoimagewriter
    kdePackages.kcalc
    kdePackages.filelight
    onlyoffice-desktopeditors
  ];

  # Install a web browser
  programs.firefox.enable = true;
}
