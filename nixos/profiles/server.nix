{ ... }:

{
  imports = [
    ../features/locale.nix
    ../features/plymouth.nix
    ../features/podman.nix

    ../services/ssh.nix
    ../services/tailscale.nix
  ];
}
