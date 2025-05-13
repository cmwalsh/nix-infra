{ ... }: {

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
      EDITOR = "vim";
      VISUAL = "vim";
    };
    
    initExtra = ''
      # case insensitive path-completion
      autoload -U compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };
}
