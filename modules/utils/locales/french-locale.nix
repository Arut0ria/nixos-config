{ ... }:
{
  flake.nixosModules.french-locale =
    { ... }:
    {
      time.timeZone = "Europe/Paris";
      i18n.defaultLocale = "fr_FR.UTF-8";

      console = {
        font = "Lat2-Terminus16";
        keyMap = "fr";
      };

      services = {
        xserver = {
          xkb.layout = "fr";
          xkb.options = "eurosign:e,caps,escape";
        };
      };
    };
}
