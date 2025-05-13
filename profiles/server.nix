{ ... }: {

  imports = [
    ../nixos/features/nix.nix
    ../nixos/features/locale.nix
    ../nixos/features/podman.nix

    ../nixos/services/ssh.nix
    ../nixos/services/mdns.nix
    ../nixos/services/tailscale.nix
  ];
}
