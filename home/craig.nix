{ pkgs, pkgs-unstable, ... }: {

  home = {
    username = "craig";
    homeDirectory = "/home/craig";
    stateVersion = "24.11";

    packages =
      (with pkgs; [
        # Dev
        nodejs_22
        pnpm
        vscode
        nixd
        nil
        nixpkgs-fmt

        # Multimedia
        ffmpeg-full
        lame
        mpv
        vdhcoapp
        spotify
        haruna
        gimp

        # Comms
        discord
        teams-for-linux
        mumble
        element-desktop

        # Productivity
        obsidian
        thunderbird-128
        protonmail-desktop
        google-chrome

        # Utility
        bitwarden
        ventoy
        vorta

        # Shell
        zsh
        kitty
        starship

        # Overrides
        (callPackage ../pkgs/freeshow {})
      ])
      ++ (with pkgs-unstable; [
        # Dev
        deno
        zed-editor

        #Utilities
        cryptomator
        picocrypt
        picocrypt-cli
        ghostty
      ]);
  };

  # Enable home manager and target generic linux
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  # Setup connection to libvirt
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # SSH
  programs.ssh = {
    enable = true;
    
    extraConfig = ''
      IdentityFile ~/.ssh/id_ed25519
    '';

    matchBlocks.firefly = {
      user = "sysadmin";
      hostname = "192.168.3.5";
    };

    matchBlocks.rocinante = {
      user = "sysadmin";
      hostname = "192.168.3.6";
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Craig";
    userEmail = "319043+cmwalsh@users.noreply.github.com";

    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };

  # Kitty
  programs.kitty = {
    enable = true;
    themeFile = "Japanesque";
    shellIntegration.enableZshIntegration = true;

    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 12;
    };

    settings = {
      enable_audio_bell = false;
    };
  };

  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
      z = "zoxide";
    };

    sessionVariables = {
      EDITOR = "micro";
      VISUAL = "micro";
      PNPM_HOME = "/home/craig/.config/pnpm/global";
    };
    
    initExtra = ''
      # case insensitive path-completion
      autoload -U compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      # Set the path for pnpm binaries
      path+=('/home/craig/.config/pnpm/global')

      # kitty ssh fix
      [[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"
    '';
  };

  # Starship
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
    };
  };


}
