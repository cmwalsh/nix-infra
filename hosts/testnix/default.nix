{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuraton.nix
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
