{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../nixos/profiles/workstation.nix
  ];

  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    hostName = "carbon";
    # hostId = "";
    domain = "serenity.lan";
    networkmanager.enable = true;
  };

  # Enable ZSH
  programs.zsh.enable = true;

  # Users
  users.users.craig = {
    isNormalUser = true;
    description = "Craig";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
