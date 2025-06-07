{ config, inputs, lib, pkgs, ... }: {

  imports = [
    inputs.disko.nixosModules.disko
    ./disks.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "uas"
      "sd_mod"
    ];

    kernelModules = [
      "kvm-intel"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
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

  # Networking
  networking = {
    hostName = "testnix";
    hostId = "c2d6e917";
    domain = "serenity.lan";

    interfaces.eth0.ipv4.addresses = [{
      address = "192.168.3.5";
      prefixLength = 24;
    }];

    defaultGateway = "192.168.3.12";
    nameservers = [ "192.168.3.6" ];
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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICtwCkGPSmJ66tDHT7Us3YA71WGJN4g/dfmuUd1AVCIK craig@jarvis"
    ];
  };

  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" testnix";
}
