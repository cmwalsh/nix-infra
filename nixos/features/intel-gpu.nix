{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      intel-compute-runtime
    ];
  };

  # https://wiki.nixos.org/wiki/Jellyfin#Troubleshooting_VAAPI_and_Intel_QSV
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}
