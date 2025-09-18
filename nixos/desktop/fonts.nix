{ pkgs, ... }:

{
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
      inter

      # Nerd Fonts
      nerd-fonts.inconsolata
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];
  };
}
