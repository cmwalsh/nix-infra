{ ... }: {

  programs.git = {
    enable = true;
    userName = "Craig (Sysadmin)";
    userEmail = "319043+cmwalsh@users.noreply.github.com";

    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };
}
