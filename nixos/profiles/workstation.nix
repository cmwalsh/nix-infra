{pkgs, ...}: {

  imports = [
    ../desktops/kde.nix
    ../services/xserver.nix
    ../services/pipewire.nix
    ../services/flatpak.nix
    ../services/mullvad.nix
    ../features/1password.nix
    ../features/fonts.nix
    ../features/bluetooth.nix
    ../features/plymouth.nix
  ];

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # Enable OpenCL
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  # Install a web browser
  programs.firefox.enable = true;
}
