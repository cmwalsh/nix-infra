{ pkgs, ... }:

{
  # Xserver
  services.xserver = {
    enable = true;

    # X11 keymap
    xkb = {
      layout = "gb";
      variant = "";
    };

    # Disable xterm
    excludePackages = [ pkgs.xterm ];
    desktopManager.xterm.enable = false;
  };

  # Wayland support in Electron apps
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
