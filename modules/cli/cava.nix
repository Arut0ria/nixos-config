{
  ...
}:
{
  flake.homeModules.cava =
    {
      ...
    }:
    {
      config = {
        # stylix.targets.cava.rainbow.enable = lib.mkIf (builtins.hasAttr "stylix" args.inputs) true;
        programs.cava = {
          enable = true;
        };
      };
    };
}
