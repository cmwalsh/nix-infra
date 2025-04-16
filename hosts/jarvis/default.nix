{ inputs, pkgs, ... }: {

  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
  ];

  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
  };

  # Bootloader
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };

    # plymouth.enable = true;

    # # Enable "Silent Boot"
    # consoleLogLevel = 0;
    # initrd.systemd.enable = true;
    # initrd.verbose = false;

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # Recognise external blu ray drive
    kernelModules = [ "sg" ];
  };

  # Networking
  networking = {
    hostName = "jarvis";
    hostId = "0acc259e";
    domain = "serenity.lan";
    networkmanager.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Firmware updates
  # https://nixos.wiki/wiki/Fwupd
  services = {
    fwupd.enable = true;
    smartd.enable = true;
  };

  # Enable ZSH
  programs.zsh.enable = true;

  # Users
  users.users.craig = {
    isNormalUser = true;
    description = "Craig";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
    ];
  };

  # Welcome message
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" jarvis";
}
