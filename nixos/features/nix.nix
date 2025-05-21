{ inputs, pkgs, ... }: {

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
      podman
      zoxide
      eza
      bat
      mc
      fzf
      jq
      sops
      age
      ssh-to-age
    ];

    variables = {
      EDITOR = "vim";
      SYSTEMD_EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  # Find out what this does!
  # Needed for vscode ssh to work
  programs.nix-ld.enable = true;

  # Allow the EOL electron version
  nixpkgs.config.permittedInsecurePackages = [
    "electron-33.4.11"
  ];

  system.stateVersion = "24.11";
}
