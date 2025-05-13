{ pkgs, ... }: {

  # Fonts
  fonts = {
    fontconfig = {
      enable = true;
      subpixel.rgba = "bgr";
      subpixel.lcdfilter = "legacy";
      hinting.style = "full";
    };

    packages = with pkgs; [
      recursive
      atkinson-hyperlegible
      cascadia-code
      jetbrains-mono
      rubik
      corefonts
      vistafonts

      # Nerd Fonts
      inconsolata-nerdfont
      fira-code-nerdfont
      inter-nerdfont
      nerdfonts
    ];
  };
}
