{ ... }:

{
  imports = [
    ./_mixins/programs/git.nix
    ./_mixins/programs/ssh.nix
    ./_mixins/programs/tmux.nix
    ./_mixins/programs/zsh.nix
    ./_mixins/programs/starship.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
