{ pkgs, ... }: {

  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # OpenCL for AMD
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}
