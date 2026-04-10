{ ... }:
{

  flake.homeModules.kitty-config =
    { ... }:
    {
      programs.kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
      };
    };
}
