{ ... }:
{
  flake.homeModules.firefox =
    {
      config,
      lib,
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

        stylix.targets.firefox.profileNames = lib.mkIf config.stylix.enable [
          "${me.username}"
        ];
      };
    };
}
