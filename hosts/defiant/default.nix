{ config, inputs, lib, pkgs, ... }: {

  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    ./disks.nix

    ../../nixos/features/opengl-amd.nix
    ../../nixos/features/bluetooth.nix
  ];

  # Required for WiFi to work
  hardware.enableRedistributableFirmware = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

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
  };

  # Firmware updates
  # https://nixos.wiki/wiki/Fwupd
  services = {
    fwupd.enable = true;
    smartd.enable = true;
  };

  # ZRam
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
  };

  # Use the AMD driver
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
  };

  # Networking
  networking = {
    hostName = "defiant";
    hostId = "c653d30b";
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
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" defiant";
}
