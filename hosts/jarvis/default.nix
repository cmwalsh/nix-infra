{ config, inputs, lib, pkgs, ... }: {

  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    ./disks.nix

    ../../nixos/features/bluetooth.nix
    ../../nixos/features/opengl-amd.nix
    ../../nixos/features/gpu-nvidia.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "sr_mod"
    ];

    kernelModules = [
      "kvm-amd"
      "nvidia"
      "sg"
    ];

    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  # ZRam
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
  };

  # Firmware updates
  # https://nixos.wiki/wiki/Fwupd
  services = {
    fwupd.enable = true;
    smartd.enable = true;
  };

  # Use the Nvidia driver
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  # Networking
  networking = {
    hostName = "jarvis";
    hostId = "0acc259e";
    domain = "serenity.lan";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [ 22 ];
    };
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
    ];
  };

  # Keep it secret, keep it safe
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;

    age = {
      sshKeyPaths = [ "/home/craig/.ssh/id_ed25519" ];
      keyFile = "/home/craig/.config/sops/age/keys.txt";
      generateKey = false;
    };

    secrets = {
      test = {};
    };
  };

  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" jarvis";
}
