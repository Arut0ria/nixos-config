{ moduleWithSystem, ... }:
{
  flake.homeModules.sddm-face = moduleWithSystem (
    perSystem@{ self', ... }:
    nixos@{ lib, ... }:
    {
      config = {
        home.file.".face.icon".source = lib.mkDefault "${self'.packages.ressources}/share/sddm_icon.png";
      };
    }
  );
}
