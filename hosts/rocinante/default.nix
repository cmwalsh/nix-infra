{ inputs, ... }: {

  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix

    ../../nixos/services/ssh.nix
    ../../nixos/services/tailscale.nix
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
    hostId = "609e7390";
    domain = "serenity.lan";

    interfaces.eth0 = {
      ipv4.addresses = [
        {
          address = "192.168.3.6";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = "192.168.3.1";
    nameservers = ["192.168.3.1"];

    firewall.enable = false;
  };

  # Users
  users.users.sysadmin = {
    isNormalUser = true;
    description = "System Administrator";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOVV3xTFd1hjc5aN6GAR3o4IolycsQ+XAtoZbT3cRXmh craig@defiant"
    ];
  };

  # Welcome message
  programs.bash.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" rocinante";

  # Podman containers
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers = {
      backend = "podman";
      containers = {
        omada = import ../../nixos/containers/omada.nix;
      };
    };
  };
}
