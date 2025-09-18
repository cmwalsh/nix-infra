{ ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    clock24 = true;
    baseIndex = 1;
    escapeTime = 0;
    newSession = true;
  };
}
