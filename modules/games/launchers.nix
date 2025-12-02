{ system, pkgs, config, lib, ... }:
{
  options = {
    launchers-module.enable = lib.mkEnableOption "Enables steam";
  };

  config = lib.mkIf config.launchers-module.enable
    {
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      programs.gamemode.enable = true;

      # No need for this I think...
      # environment.sessionVariables = {
      #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      # };
    };
}
