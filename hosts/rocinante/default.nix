{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ../../nixos/profiles/server.nix

    # Containers on this host
    ../../nixos/containers/omada-controller.nix
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
    hostName = "rocinante";
    # hostId = "";
    domain = "rocinante.lan";

    interfaces.eth0 = {
      ipv4.addresses = [
        {
          address = "192.168.3.6";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = "192.168.3.1";
    nameservers = ["192.168.3.6"];
  };

  # Users
  users.users.sysadmin = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = ["wheel"];
  };

  # Welcome message
  programs.bash.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" rocinante";
}
