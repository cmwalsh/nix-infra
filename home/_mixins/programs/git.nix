{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Craig Walsh";
    userEmail = "280180-craigw@users.noreply.gitlab.com";
    diff-so-fancy.enable = true;
    extraConfig.init.defaultBranch = "main";
  };
}
