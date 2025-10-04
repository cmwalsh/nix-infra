{ ... }:

{
  imports = [
    ../features/locale.nix

    ../services/ssh.nix
    ../services/tailscale.nix
  ];
}
