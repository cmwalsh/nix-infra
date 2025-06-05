{ config, inputs, lib, pkgs, ... }: {

  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    ./disks.nix

    ../../nixos/services/technitium.nix
    ../../nixos/containers/omada.nix
    ../../nixos/containers/crafty.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "uas"
      "sd_mod"
      "sr_mod"
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
    hostName = "rocinante";
    hostId = "bcc59111";
    domain = "serenity.lan";

    interfaces.eth0.ipv4.addresses = [{
      address = "192.168.3.6";
      prefixLength = 24;
    }];

    defaultGateway = "192.168.3.1";
    nameservers = [ "127.0.0.1" ];

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];   
      allowedTCPPorts = [ 22 ];
    };
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
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" rocinante";
}
