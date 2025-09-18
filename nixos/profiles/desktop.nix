{ pkgs, ... }:

{
  imports = [
    ../features/locale.nix
    ../features/plymouth.nix
    ../features/bluetooth.nix
    ../features/libvirt.nix
    ../features/podman.nix

    ../services/ssh.nix
    ../services/tailscale.nix

    ../desktop/xserver.nix
    ../desktop/pipewire.nix
    ../desktop/fonts.nix
    ../desktop/printing.nix
    ../desktop/udev.nix
    ../desktop/flatpak.nix
  ];

  # Browsers
  environment = {
    systemPackages = with pkgs; [
      firefox
      brave
    ];
  };
}
