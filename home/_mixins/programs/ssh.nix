{ ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "raven" = {
        host = "raven";
        hostname = "192.168.3.4";
        user = "sysadmin";
        identityFile = "~/.ssh/id_ed25519";

        setEnv = {
          TERM = "xterm-256color";
        };
      };

      "titan" = {
        host = "titan";
        hostname = "192.168.3.5";
        user = "sysadmin";
        identityFile = "~/.ssh/id_ed25519";

        setEnv = {
          TERM = "xterm-256color";
        };
      };

      "cube" = {
        host = "cube";
        hostname = "192.168.3.59";
        user = "sysadmin";
        identityFile = "~/.ssh/id_ed25519";

        setEnv = {
          TERM = "xterm-256color";
        };
      };

      "holodeck" = {
        host = "holodeck";
        hostname = "192.168.3.30";
        user = "sysadmin";
        # identityFile = "~/.ssh/id_ed25519";

        setEnv = {
          TERM = "xterm-256color";
        };
      };
    };
  };
}
