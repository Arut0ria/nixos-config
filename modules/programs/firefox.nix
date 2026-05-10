{ ... }:
{
  flake.homeModules.firefox =
    {
      config,
      lib,
      options,
      ...
    }:
    let
      inherit (config) me;
    in
    {
      config = {
        programs.firefox = {
          enable = true;
          profiles = {
            ${me.username} = {
              isDefault = true;
              name = "${me.username}";
            };
          };
        };
      }
      // (lib.optionalAttrs (builtins.hasAttr "stylix" options) {
        stylix.targets.firefox.profileNames = [ "${me.username}" ];
      });
    };
}
