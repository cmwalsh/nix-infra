{ ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Japanesque";
    shellIntegration.enableZshIntegration = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      enable_audio_bell = false;
    };
  };
}
