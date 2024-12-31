{ inputs, ... }: {

  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix

    ../../nixos/services/zfs.nix
    ../../nixos/services/ssh.nix
    ../../nixos/services/tailscale.nix
    ../../nixos/services/podman.nix
    ../../nixos/services/samba.nix

    ../../nixos/features/intel-gpu.nix
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
    hostName = "firefly";
    hostId = "e89d6cdd";
    domain = "serenity.lan";

    interfaces.eth0 = {
      ipv4.addresses = [
        {
          address = "192.168.3.5";
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
    extraGroups = ["wheel" "podman"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOVV3xTFd1hjc5aN6GAR3o4IolycsQ+XAtoZbT3cRXmh craig@defiant"
    ];
  };

  users.users.media = {
    isNormalUser = true;
    description = "Media";
    extraGroups = [];
  };

  # Welcome message
  programs.bash.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" firefly";
}
