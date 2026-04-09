{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.stylix-plasma-config = moduleWithSystem (
    perSystem@{
      self',
      ...
    }:
    nixos@{
      lib,
      config,
      pkgs,
      ...
    }:
    let
      cfg = config.stylix-plasma-config;
    in
    {
      options = {
        stylix-plasma-config.background = lib.mkOption {
          type = lib.types.path;
          default = "${self'.packages.ressources}/share/background_1.png";
          description = "'Name of the background image to use, add to the res directory / package.";
        };
      };

      config = {
        environment.systemPackages = [
          (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
            [General]
            background=${cfg.background}
          '')
        ];
      };
    }
  );
}
