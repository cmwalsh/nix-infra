{ ... }: {

  imports = [
    ../nixos/desktop/xserver.nix
    ../nixos/desktop/kde.nix
    ../nixos/desktop/pipewire.nix
    ../nixos/desktop/printing.nix
    ../nixos/desktop/firefox.nix
    ../nixos/desktop/gaming.nix

    ../nixos/features/nix.nix
    ../nixos/features/locale.nix
    ../nixos/features/plymouth.nix
    ../nixos/features/fonts.nix
    ../nixos/features/virtualisation.nix
    ../nixos/features/podman.nix

    ../nixos/services/mdns.nix
    ../nixos/services/tailscale.nix
  ];
}
