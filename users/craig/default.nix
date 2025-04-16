{ pkgs, pkgs-unstable, ... }: {

  imports = [
    ./git.nix
    ./shell.nix
    ./libvirt.nix
  ];

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

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
        ansible
        ansible-lint

        # Multimedia
        ffmpeg-full
        lame
        mpv
        vdhcoapp
        spotify
        haruna
        gimp
        reaper
        asunder
        picard
        audacious
        audacity
        musescore

        # Comms
        discord
        teams-for-linux
        mumble

        # Productivity
        obsidian
        thunderbird-128
        brave

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

        # Books
        calibre
        libation

        #Utilities
        cryptomator
        picocrypt
        picocrypt-cli
        ghostty
      ]);
  };
}
