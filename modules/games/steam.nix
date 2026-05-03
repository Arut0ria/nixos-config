{ ... }:
{
  flake.nixosModules.steam =
    { ... }:
    {
      config = {
        programs.steam = {
          enable = true;
          gamescopeSession.enable = true;
        };

        hardware.steam-hardware.enable = true;
      };
    };
  # No need for this I think...
  # environment.sessionVariables = {
  #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  # };
}
