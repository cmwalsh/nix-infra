{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Craig Walsh";
    userEmail = "319043+cmwalsh@users.noreply.github.com";
    diff-so-fancy.enable = true;
    extraConfig.init.defaultBranch = "main";
  };
}
