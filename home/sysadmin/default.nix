{
  ...
}: {
  home = {
    username = "sysadmin";
    homeDirectory = "/home/sysadmin";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  # Configure Git
  programs.git = {
    enable = true;
    userName = "Sysadmin";
    userEmail = "sysadmin@cwbt.uk";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        default = "matching";
      };
        pull = {
        rebase = false;
      };
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

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };
}
