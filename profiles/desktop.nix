{ ... }: {

  imports = [
    ../nixos/bluetooth.nix
    ../nixos/common.nix
    ../nixos/flatpak.nix
    ../nixos/fonts.nix
    ../nixos/kde.nix
    ../nixos/locale.nix
    ../nixos/pipewire.nix
    ../nixos/podman.nix
    ../nixos/virt-manager.nix
  ];
}
