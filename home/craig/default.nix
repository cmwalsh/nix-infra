{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home = {
    username = "craig";
    homeDirectory = "/home/craig";
    stateVersion = "24.11";

    # sessionVariables = {
    #   PNPM_HOME = "/home/craig/.config/pnpm/global";
    # };

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

  # Enable home manager and target generic linux
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  # # Configure Git
  # programs.git = {
  #   enable = true;
  #   userName = "Craig W";
  #   userEmail = "craigw@pm.me";
  #   extraConfig = {
  #     init = {
  #       defaultBranch = "main";
  #     };
  #     push = {
  #       default = "matching";
  #     };
  #       pull = {
  #       rebase = false;
  #     };
  #   };
  # };

  # # Terminal
  # programs.kitty = {
  #   enable = true;
  #   themeFile = "Japanesque";

  #   font = {
  #     name = "CaskaydiaCove Nerd Font";
  #     size = 12;
  #   };

  #   shellIntegration = {
  #     enableZshIntegration = true;
  #   };
  # };

  # # ZSH
  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   autosuggestion.enable = true;
  #   syntaxHighlighting.enable = true;

  #   initExtra = ''
  #     autoload -Uz +X compinit && compinit
  #     ## case insensitive path-completion
  #     zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  #     zstyle ':completion:*' menu select
  #     path+=('/home/craig/.config/pnpm/global')

  #     # kitty ssh fix
  #     [[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"
  #   '';
  # };

  # # Starship
  # programs.starship = {
  #   enable = true;
  # };

  # Setup connection to libvirt
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
