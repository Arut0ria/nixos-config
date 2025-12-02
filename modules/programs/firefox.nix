{ lib, config, ... }:
let
  inherit (config) me;
in
{
  options = {
    firefox-module.enable = lib.mkEnableOption "Enables firefox.";
  };

  config = lib.mkIf config.firefox-module.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        ${me.username} = {
          isDefault = true;
          name = "${me.username}";
        };
      };
    };

    stylix.targets.firefox.profileNames = lib.mkIf ((builtins.hasAttr "stylix" config)) [ "${me.username}" ];
  };
}
