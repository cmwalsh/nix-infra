{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t495

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
      "ehci_pci"
      "xhci_pci"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

    kernelModules = [
      "kvm-amd"
      "sg"
    ];

    kernelParams = [
      "acpi_backlight=native"
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
    hostName = "equinox";
    hostId = "0f3987ed";
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
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" equinox";
}
