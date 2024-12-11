{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../nixos/profiles/server.nix
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

  # Fix for running ZFS in a virtual machine
  # https://nixos.wiki/wiki/ZFS (at the end)
  boot.zfs.devNodes = "/dev/disk/by-partuuid";

  # Networking
  networking = {
    hostName = "testnix";
    hostId = "c3da6ae5";
    domain = "serenity.lan";
  };

  # Users
  users.users.sysadmin = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = ["wheel"];
  };

  users.users.media = {
    isNormalUser = true;
    description = "Media";
    extraGroups = [];
  };

  # Welcome message
  programs.bash.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" testnix";
}
