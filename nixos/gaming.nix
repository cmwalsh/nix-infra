{ pkgs, ... }: {

  programs = {
    gamemode.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true;
      #remotePlay.openFirewall = true;
	    #dedicatedServer.openFirewall = true;
    };
  };

  environment.systemPackages = with pkgs; [
    bottles
    heroic
    protonup-qt
    winetricks
    wineWowPackages.waylandFull
  ];
}
