{pkgs, ...}: {
  services.bind = {
    enable = true;

    extraConfig = ''
      acl internal-net {
        localhost;
        192.168/16;
      };

      server ::/0 {
        bogus yes;
      };
    '';

    extraOptions = ''
      allow-query { internal-net; };
      allow-query-cache { internal-net; };
      allow-recursion { none; };
      allow-transfer { none; };

      check-names master ignore;
      check-names slave ignore;
      check-names response ignore;

      notify no;
    '';

    zones = {
      "serenity.lan" = {
        file = pkgs.writeText "zone-serenity" ''
          $ORIGIN .
          $TTL 907200 ; 1 week 3 days 12 hours

          serenity.lan    IN    SOA   dns.serenity.lan.   webmaster.serenity.lan. (
                                      2711202401 ; serial
                                      10800      ; refresh (3 hours)
                                      3600       ; retry (1 hour)
                                      604800     ; expire (1 week)
                                      38400      ; minimum (10 hours 40 minutes)
                                )
                          NS    dns.serenity.lan.

          $ORGIGIN serenity.lan.
          router          A     192.168.3.1
          switch          A     192.168.3.2
          firefly         A     192.168.3.5
          rocinante       A     192.168.3.6
        '';
      };
    };
  };
}
