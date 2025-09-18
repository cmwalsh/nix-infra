{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      font-size = 12;
      font-family = "JetBrainsMono Nerd Font";
      theme = "Japanesque";
      window-height = 40;
      window-width = 140;
    };
  };
}
