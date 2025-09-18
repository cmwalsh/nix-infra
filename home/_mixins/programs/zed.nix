{ ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "svelte"
      "astro"
      "justfile"
    ];

    userSettings = {
      tab_size = 2;
      format_on_save = "on";
    };
  };
}
