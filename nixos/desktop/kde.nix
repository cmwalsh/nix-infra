{ pkgs, ... }:

{
  # KDE 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

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
    exfatprogs
  ];

  # Make Firefox use the KDE file picker.
  # Preferences source: https://wiki.archlinux.org/title/firefox#KDE_integration
  programs.firefox = {
    enable = true;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}
