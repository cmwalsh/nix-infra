{ pkgs, ... }:

{
  hardware.graphics = {
    # OpenGL
    enable = true;
    enable32Bit = true;

    # OpenCL for AMD
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}
