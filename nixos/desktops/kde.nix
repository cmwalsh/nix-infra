{ pkgs, ... }: {

  imports = [
    ../services/xserver.nix
    ../services/pipewire.nix
    ../services/flatpak.nix

    ../features/bluetooth.nix
    ../features/fonts.nix
    ../features/plymouth.nix
  ];

  # KDE 6
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

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
    libreoffice-qt
  ];

  # Install a web browser
  programs.firefox.enable = true;
}
