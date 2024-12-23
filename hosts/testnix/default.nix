{inputs, pkgs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../nixos/features/zfs.nix
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
  boot.zfs.extraPools = [ "ironwolf" ];

  # Networking
  networking = {
    hostName = "testnix";
    hostId = "c3da6ae5";
    domain = "serenity.lan";
  };

  # Open SSH for this configuration only
  services.openssh.enable = true;

  # Enable ZSH
  programs.zsh.enable = true;

  # Users
  users.users.sysadmin = {
    isNormalUser = true;
    description = "System Administrator";
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };

  users.users.media = {
    isNormalUser = true;
    description = "Media";
    extraGroups = [];
  };

  # Welcome message
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" testnix";
}
