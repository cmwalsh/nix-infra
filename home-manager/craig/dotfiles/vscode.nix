{ pkgs, ... }: {

  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        esbenp.prettier-vscode
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        astro-build.astro-vscode
        redhat.ansible
        jnoortheen.nix-ide
        brettm12345.nixfmt-vscode
        pkief.material-icon-theme
        vue.volar
        vue.vscode-typescript-vue-plugin
      ];

      userSettings = {
        "editor.fontFamily" = "'JetBrainsMono Nerd Font','Droid Sans Mono', 'monospace', monospace";
        "editor.tabSize" = 2;
        "editor.minimap.enabled" = false;
        "editor.stickyScroll.enabled" = false;
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
        "breadcrumbs.enabled" = false;
        "update.mode" = "manual";
        "ansible.lightspeed.enabled" = false;
      };
    };
  };
}
