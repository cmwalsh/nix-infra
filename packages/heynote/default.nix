{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
}: let
  pname = "heynote";
  version = "1.8.0";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/heyman/heynote/releases/download/v${version}/Heynote_${version}_x86_64.AppImage";
    sha256 = "sha256-NzrXV8HmCPYE+D3tEwVv3rBkLF0/FKW6uJdqhKmH8uw=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname name src;
  };
in
  appimageTools.wrapType2 {
    inherit pname name src;

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/heynote.desktop $out/share/applications/${pname}.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/0x0/apps/${pname}.png \
        $out/share/icons/hicolor/512x512/apps/${pname}.png

      # Fix desktop file
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}' \
        --replace 'Icon=heynote' 'Icon=${pname}'
    '';

    meta = with lib; {
      description = "A dedicated scratchpad for developers";
      homepage = "https://github.com/heyman/heynote";
      license = licenses.mit;
      platforms = platforms.linux;
      maintainers = [];
    };
  }
