{ moduleWithSystem, inputs, ... }:
{
  flake.nixosModules.stylix-base-config = moduleWithSystem (
    perSystem@{
      self',
      ...
    }:
    nixos@{ lib, ... }:
    {
      config = {
        stylix = {
          enable = lib.mkDefault true;
          autoEnable = lib.mkDefault true;
          image = "${self'.packages.ressources}/share/background_1.png";

          polarity = "dark";

          opacity = {
            terminal = 0.9;
            popups = 0.9;
            applications = 0.95;
            desktop = 0.9;
          };

          targets = {
            grub.useWallpaper = true;
          };

          override.base05 = "FFFFFF";
        };
      };
    }
  );
}
