{ pkgs, pkgs-unstable, ... }: {

  imports = [
    ./dotfiles/git.nix
    ./dotfiles/zsh.nix
  ];

  home = {
    username = "sysadmin";
    homeDirectory = "/home/sysadmin";
    stateVersion = "24.11";

    packages =
      (with pkgs; [
        zsh
      ])
      ++ (with pkgs-unstable; [

      ]);
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
