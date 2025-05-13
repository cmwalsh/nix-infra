{ pkgs, ... }: {

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  hardware.firmware = [ pkgs.linux-firmware ];

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver
      intel-compute-runtime
      vpl-gpu-rt
      intel-ocl
    ];
  };
}
