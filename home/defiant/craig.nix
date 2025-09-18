{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../common.nix

    ../_mixins/programs/ghostty.nix
    ../_mixins/programs/vscode.nix
    ../_mixins/programs/virt-manager.nix
  ];

  home = {
    username = "craig";
    homeDirectory = "/home/craig";

    packages =
      (with pkgs; [
        # CLI
        ghostty

        # Dev
        nodejs_22
        deno
        bun
        pnpm
        ansible
        ansible-lint

        # Multimedia
        ffmpeg-full
        lame
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
        makemkv

        # Photography
        rapid-photo-downloader
        darktable
        gthumb

        # Comms
        discord
        teams-for-linux
        mumble

        # Productivity
        thunderbird-128
        onlyoffice-desktopeditors
        filezilla
        gnucash

        # Utility
        vorta
        protonvpn-gui
        via
        podman-desktop
        heynote
        _1password-gui
        pika-backup

        # Games
        jdk
        prismlauncher
        pychess
        wesnoth

      ])
      ++ (with pkgs-unstable; [
        # Dev
        zed-editor
        nixd
        nil

        # Books
        calibre
        libation

        #Utilities
        cryptomator
        picocrypt
        picocrypt-cli
      ]);
  };
}
