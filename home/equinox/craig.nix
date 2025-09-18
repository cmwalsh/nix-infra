{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../common.nix

    ../_mixins/programs/ghostty.nix
  ];

  home = {
    username = "craig";
    homeDirectory = "/home/craig";

    packages =
      (with pkgs; [
        # CLI
        ghostty
      ])
      ++ (with pkgs-unstable; [
        # Dev
        zed-editor
        nixd
        nil
      ]);
  };
}
