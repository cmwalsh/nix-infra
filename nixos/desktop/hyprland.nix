{ pkgs, ... }:

{
  imports = [
    ../greeters/sddm.nix
  ];

  # Enable required services
  services.dbus.enable = true;

  # Hyprland compositor
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Wayland portal setup (ensures screenshots, screenshare work)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # Useful base packages
  environment.systemPackages = with pkgs; [
    wl-clipboard
    grim
    slurp
    libnotify
  ];

  # For screen locking PAM
  security.pam.services.hyprlock = { };
}
