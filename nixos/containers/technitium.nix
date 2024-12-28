{
  image = "technitium/dns-server:latest";
  hostname = "technitium";
  autoStart = true;

  environment = {
    DNS_SERVER_DOMAIN = "serenity.lan";
  };

  ports = [
    "5380:5380/tcp"
    "53:53/udp"
    "53:53/tcp"
  ];

  volumes = [
    "/home/sysadmin/containers/technitium:/etc/dns"
  ];

  extraOptions = [
    "--sysctl net.ipv4.ip_local_port_range=1024 65000"
  ];
}
