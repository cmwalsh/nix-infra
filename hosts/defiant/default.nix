{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd

    ./disko.nix
    ./home-manager.nix

    ../../nixos
    ../../nixos/profiles/desktop.nix
    ../../nixos/features/amd-gpu.nix
    ../../nixos/desktop/kde.nix
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

  # Graphics
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
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
      "thunderbolt"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = [
      "kvm-amd"
      "sg"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    # zfs.extraPools = [ ];
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
    hostName = "defiant";
    hostId = "7b65aad8";
    domain = "serenity.lan";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # Users
  users.users.craig = {
    isNormalUser = true;
    description = "Craig";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "podman"
      "video"
      "render"
      "audio"
    ];
  };

  # Shell
  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" defiant";
}
