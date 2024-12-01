{
  inputs,
  pkgs,
  ...
}: {
  # imports = [
  #   inputs.sops-nix.nixosModules.sops
  # ];

  nix = {
    # Use flakes
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      auto-optimise-store = true;
    };

    # Collect garbage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5";
    };

    # channel.enable = false;
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Common packages
  environment = {
    systemPackages = with pkgs; [
      git
      micro
      vim
      lazygit
      curl
      dnsutils
      iperf3
      pciutils
      rsync
      tree
      lsof
      tmux
      usbutils
      wget
      nmap
      magic-wormhole
      sops
      age
      ssh-to-age
      wl-clipboard
      unzip
      borgbackup
    ];

    variables = {
      EDITOR = "micro";
      SYSTEMD_EDITOR = "micro";
      VISUAL = "micro";
    };
  };

  # Firmware updates
  # https://nixos.wiki/wiki/Fwupd
  services = {
    fwupd.enable = true;
    smartd.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure console keymap
  console.keyMap = "uk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # SOPS configuration
  # sops = {
  #   defaultSopsFile = ../../secrets/serenity.yaml;
  #   validateSopsFiles = false;

  #   age = {
  #     sshKeyPaths = [ "/home/${username}/.ssh/id_ed25519" ];
  #     keyFile = "/var/lib/sops-nix/key.txt";
  #     generateKey = true;
  #   };

  #   secrets = {

  #   };
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
