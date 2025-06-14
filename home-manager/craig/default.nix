{ pkgs, pkgs-unstable, ... }: {

  imports = [
    ./dotfiles/git.nix
    ./dotfiles/kitty.nix
    ./dotfiles/ghostty.nix
    ./dotfiles/libvirt.nix
    ./dotfiles/starship.nix
    ./dotfiles/zsh.nix
    ./dotfiles/vscode.nix
    ./dotfiles/tmux.nix
    ./dotfiles/ssh.nix
  ];

  home = {
    username = "craig";
    homeDirectory = "/home/craig";
    stateVersion = "25.05";

    packages =
      (with pkgs; [
        # Dev
        nodejs_24
        deno
        bun
        pnpm
        nixpkgs-fmt
        python3
        ansible
        ansible-lint
        jetbrains.webstorm

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
        inkscape

        # Photography
        rapid-photo-downloader
        darktable

        # Comms
        discord
        teams-for-linux
        mumble

        # Productivity
        brave
        obsidian
        thunderbird-128
        onlyoffice-desktopeditors
        todoist
        filezilla

        # Utility
        vorta
        protonvpn-gui
        via
        podman-desktop

        # Shell
        zsh
        kitty
        ghostty
        starship

        # Games
        jdk
        prismlauncher
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
