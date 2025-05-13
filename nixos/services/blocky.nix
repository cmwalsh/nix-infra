{ ... }: {

  services.blocky = {
    enable = true;

    settings = {
      ports.dns = 53;

      # Use Quad9 for upstream DNS
      upstreams.groups.default = [ "https://dns11.quad9.net/dns-query" ];
      bootstrapDns.upstream = "https://dns11.quad9.net/dns-query";
      bootstrapDns.ips = [ "9.9.9.11" "149.112.112.11" ];

      # Use Hagezi lists to block ads and porn
      blocking = {
        blockType = "nxDomain";

        blackLists = {
          ads = [
            "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro.txt"
          ];

          nsfw = [
            "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/nsfw.txt"
          ];
        };

        whiteLists = {
          ads = [
            ../files/allowlist.txt
          ];
        };

        clientGroupsBlock = {
          default = [ "ads" "nsfw" ];
        };
      };
    };
  };

  services.resolved.enable = false;

  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
