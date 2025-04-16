{ config, ... }: {

  # NVIDIA
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;

    # NVIDIA driver version
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Fix for Nvidia hybernation issue
  # https://discourse.nixos.org/t/psa-for-those-with-hibernation-issues-on-nvidia/61834
  # boot.extraModprobeConfig = ''
  #   options nvidia_modeset vblank_sem_control=0
  # '';
}
