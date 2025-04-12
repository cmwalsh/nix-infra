{ ... }: {

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