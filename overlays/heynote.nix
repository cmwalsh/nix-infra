{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      heynote = prev.callPackage ../packages/heynote {
        inherit (prev) lib stdenv fetchurl appimageTools;
      };
    })
  ];
}
