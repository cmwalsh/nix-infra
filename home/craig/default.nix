{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home = {
    username = "craig";
    homeDirectory = "/home/craig";
    stateVersion = "24.11";

    packages =
      (with pkgs; [
        # Dev
        nodejs_22
        yarn-berry
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

        # Audio
        easyeffects

        # Comms
        discord
        teams-for-linux
        mumble
        element-desktop

        # Productivity
        obsidian
        thunderbird-128

        # Utility
        kitty
        ventoy
        vorta
      ])
      ++ (with pkgs-unstable; [
        # Dev
        deno
        zed-editor

        #Utilities
        cryptomator
        picocrypt
        picocrypt-cli
      ]);
  };

  programs.home-manager.enable = true;

  # Configure Git
  programs.git = {
    enable = true;
    userName = "Craig W";
    userEmail = "craigw@pm.me";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  # Terminal
  programs.kitty = {
    enable = true;
    themeFile = "Japanesque";

    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 12;
    };

    shellIntegration = {
      enableZshIntegration = true;
    };
  };

  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      autoload -Uz +X compinit && compinit
      ## case insensitive path-completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
    '';
  };

  # Starship
  programs.starship = {
    enable = true;
  };
}
