{ ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
    };

    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
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

      # Zoxide
      eval "$(zoxide init zsh)"
    '';
  };
}
