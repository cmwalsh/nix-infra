{ ... }:

{
  imports = [
    ../features/locale.nix
    ../features/podman.nix

    ../services/ssh.nix
    ../services/tailscale.nix
  ];
}
