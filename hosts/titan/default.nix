{ lib, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./home-manager.nix

    ../../nixos
    ../../nixos/profiles/server.nix
    ../../nixos/features/intel-gpu.nix
    ../../nixos/services/samba.nix
    ../../nixos/services/jellyfin.nix
    ../../nixos/services/mealie.nix
  ];

  # Hardware
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = lib.mkDefault true;
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
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "uas"
      "sd_mod"
    ];

    kernelModules = [
      "kvm-amd"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "zfs" ];

    zfs = {
      forceImportRoot = true;
      forceImportAll = true;
      devNodes = "/dev/disk/by-id";
      extraPools = [ "ironwolf" ];
    };
  };

  # ZFS
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
      pools = [
        "rpool"
        "ironwolf"
      ];
    };

    trim = {
      enable = true;
      interval = "weekly";
    };
  };

  # Network
  networking = {
    hostName = "titan";
    hostId = "f1ba3dcf";
    domain = "serenity.lan";
    dhcpcd.enable = false;

    interfaces.enp6s0.ipv4.addresses = [
      {
        address = "192.168.3.5";
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

  users.users.craig = {
    isNormalUser = true;
    description = "Craig Walsh";
  };

  users.users.mary = {
    isNormalUser = true;
    description = "Mary Walsh";
  };

  users.users.media = {
    isNormalUser = true;
    description = "Jellyfin User";
  };

  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" titan";
}
