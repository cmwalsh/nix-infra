{ ... }: {

  programs.ssh = {
    enable = true;

    matchBlocks = {
      "rocinante" = {
        host = "rocinante";
        hostname = "192.168.3.6";
        user = "sysadmin";
        identityFile = "~/.ssh/id_ed25519";
        
        setEnv = {
          TERM = "xterm-256color";
        };
      };
    };
  };
}
