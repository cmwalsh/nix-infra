{ ... }: {

  virtualisation.oci-containers.containers = {
    crafty-controller = {
      image = "registry.gitlab.com/crafty-controller/crafty-4:latest";
      hostname = "crafty";
      autoStart = true;

      environment = {
        TZ = "Europe/London";   
      };
      
      ports = [ 
        "8443:8443" # HTTPS
        "8123:8123" # DYNMAP
        "25500-25600:25500-25600" # MC SERV PORT RANGE
      ];

      volumes = [
        "/home/sysadmin/containers/crafty/backups:/crafty/backups"
        "/home/sysadmin/containers/crafty/logs:/crafty/logs"
        "/home/sysadmin/containers/crafty/servers:/crafty/servers"
        "/home/sysadmin/containers/crafty/config:/crafty/app/config"
        "/home/sysadmin/containers/crafty/import:/crafty/import"
      ];
    };
  };

  # Ensure container volume directories exist
  systemd.tmpfiles.rules = [
    "d /home/sysadmin/containers/crafty 0744 sysadmin users -"
    "d /home/sysadmin/containers/crafty/backups 0744 sysadmin users -"
    "d /home/sysadmin/containers/crafty/logs 0744 sysadmin users -"
    "d /home/sysadmin/containers/crafty/servers 0744 sysadmin users -"
    "d /home/sysadmin/containers/crafty/config 0744 sysadmin users -"
    "d /home/sysadmin/containers/crafty/import 0744 sysadmin users -"
  ];

  # Allow containers ports
  networking.firewall.allowedTCPPorts = [ 8443 8123 ];
  networking.firewall.allowedTCPPortRanges = [ { from = 25500;  to = 25600; } ];
}
