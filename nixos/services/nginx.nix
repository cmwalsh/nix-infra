{ ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts = {
      # Home Assistant
      "axiom.cwbt.uk" = {
        forceSSL = true;
        useACMEHost = "cwbt.uk";
        locations."/" = {
          proxyPass = "http://192.168.3.7:8123";
          proxyWebsockets = true;
        };
      };

      # Jellyfin
      "media.cwbt.uk" = {
        forceSSL = true;
        useACMEHost = "cwbt.uk";
        locations."/" = {
          proxyPass = "http://192.168.3.5:8096";
          proxyWebsockets = true;

          extraConfig = ''
            proxy_buffering off;
          '';
        };
      };
    };
  };

  # Allow 80 and 443
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
