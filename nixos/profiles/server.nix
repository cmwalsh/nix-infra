{...}: {
  imports = [
    ../services/openssh.nix
    # ../features/intel-gpu.nix
    ../features/podman.nix
  ];

  # Firmware updates
  # https://nixos.wiki/wiki/Fwupd
  services = {
    fwupd.enable = true;
    smartd.enable = true;
  };
}
