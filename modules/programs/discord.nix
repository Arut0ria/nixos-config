{ ... }:
{
  flake.homeModules.discord =
    { ... }:
    {
      config = {
        programs.vesktop.enable = true;
      };
    };
}
