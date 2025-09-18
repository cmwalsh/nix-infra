{ pkgs, ... }:

{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish.enable = true;
    publish.userServices = true;
    openFirewall = true;
  };

  environment = {
    systemPackages = with pkgs; [
      git
      home-manager
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
      dmidecode
      wget
      nmap
      magic-wormhole
      unzip
      borgbackup
      figurine
      sops
      age
      ssh-to-age
      zfs
      zfs-prune-snapshots
      sanoid
      zsh
      nixd
      nil
      starship
      zoxide
      eza
      bat
      mc
      fzf
      jq
      nixpkgs-fmt
      python3
    ];

    variables = {
      EDITOR = "vim";
      SYSTEMD_EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/craig/Projects/nix-infra"; # sets NH_OS_FLAKE variable for you
  };

  # Needed for vscode ssh to work
  programs.nix-ld.enable = true;

  # No man pages
  documentation.man.enable = false;

  system.stateVersion = "25.05";
}
