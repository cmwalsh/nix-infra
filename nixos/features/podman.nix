{ ... }: {

  virtualisation = {
    containers.enable = true;
    
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = false;
    };
    
    oci-containers.backend = "podman";
  };
}
