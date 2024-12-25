{ pkgs, pkgs-unstable, ... }: {

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

        # Multimedia
        ffmpeg-full
        lame
        mpv
        vdhcoapp
        spotify
        haruna

        # Comms
        discord
        teams-for-linux
        mumble
        element-desktop

        # Productivity
        obsidian
        thunderbird-128
        protonmail-desktop
        google-chrome

        # Utility
        bitwarden
        ventoy
        vorta

        # Shell
        zsh
        fish
        kitty
        starship
      ])
      ++ (with pkgs-unstable; [
        # Dev
        deno
        zed-editor

        #Utilities
        cryptomator
        picocrypt
        picocrypt-cli
      ]);
  };

  # Enable home manager and target generic linux
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  # Setup connection to libvirt
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
