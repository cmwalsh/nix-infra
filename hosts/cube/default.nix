{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./disko.nix
    ./home-manager.nix

    ../../nixos
    ../../nixos/profiles/server.nix
  ];

  # Hardware
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  services.power-profiles-daemon.enable = true;

  # Firmware updates
  # https://nixos.wiki/wiki/Fwupd
  services = {
    fwupd.enable = true;
    smartd.enable = true;
  };

  # Zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  # Kernel
  boot = {
    initrd.availableKernelModules = [
      "ehci_pci"
      "ahci"
      "uhci_hcd"
      "xhci_pci_renesas"
      "uas"
      "usbhid"
      "sd_mod"
    ];

    kernelModules = [
      "kvm-intel"
    ];

    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
        copyKernels = true;
        zfsSupport = true;
      };

      systemd-boot.enable = false;
      efi.canTouchEfiVariables = false;
    };

    supportedFilesystems = [ "zfs" ];
    zfs.devNodes = "/dev/disk/by-id";
    zfs.extraPools = [ "backup" ];
  };

  # ZFS
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
      pools = [ "rpool" ];
    };

    trim = {
      enable = true;
      interval = "weekly";
    };
  };

  # Network
  networking = {
    hostName = "cube";
    hostId = "f25a9c4b";
    domain = "serenity.lan";
    dhcpcd.enable = false;

    interfaces.eno1.ipv4.addresses = [
      {
        address = "192.168.3.59";
        prefixLength = 24;
      }
    ];

    defaultGateway = "192.168.3.1";
    nameservers = [ "192.168.3.4" ];
  };

  # Users
  users.users.sysadmin = {
    isNormalUser = true;
    description = "System Administrator";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "podman"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOVV3xTFd1hjc5aN6GAR3o4IolycsQ+XAtoZbT3cRXmh craig@defiant"
    ];
  };

  # Shell
  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" cube";
}
