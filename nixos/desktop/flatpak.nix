{ inputs, ... }:

{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;

    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };

    packages = [
      "md.obsidian.Obsidian"
      "com.bitwarden.desktop"
      "com.github.sakya.corechess"
      "io.github.mimoguz.tripeaks_neue"
    ];
  };
}
