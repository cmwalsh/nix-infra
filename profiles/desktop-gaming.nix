{ ... }: {

  imports = [
    ./desktop.nix
    ../nixos/nvidia.nix
    ../nixos/gaming.nix
  ];
}
