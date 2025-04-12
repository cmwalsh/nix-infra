{ ... }: {

  # Git
  programs.git = {
    enable = true;
    userName = "Craig";
    userEmail = "319043+cmwalsh@users.noreply.github.com";

    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };
}
