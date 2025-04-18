{ pkgs, ... }: {

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

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
      unzip
      borgbackup
      figurine
      stow
      podman
      zoxide
      eza
      bat
      mc
      fzf
    ];

    variables = {
      EDITOR = "micro";
      SYSTEMD_EDITOR = "micro";
      VISUAL = "micro";
    };
  };

  system.stateVersion = "24.11";
}