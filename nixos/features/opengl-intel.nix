{ pkgs, ... }: {

  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # OpenCL for Intel
    extraPackages = with pkgs; [
      intel-ocl
    ];
  };
}
