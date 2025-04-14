{ config, ... }: {

  # NVIDIA
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;

    # NVIDIA driver version
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
