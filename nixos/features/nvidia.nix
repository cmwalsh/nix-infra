{ config, ... }: {

  # NVIDIA
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;

    # NVIDIA driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
