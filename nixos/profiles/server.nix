{...}: {
  imports = [
    ../services/openssh.nix
    ../features/intel-gpu.nix
    ../features/podman.nix
  ];
}
