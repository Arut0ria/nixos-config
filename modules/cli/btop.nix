{
  ...
}:
{
  flake.homeModules.btop =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      options = {
        btop-use-cuda = lib.mkOption {
          type = lib.types.bool;
          description = "Define if using cuda package version of btop.";
          default = false;
        };
      };

      config = {
        programs.btop = {
          enable = true;
          package = if (config.btop-use-cuda) then (pkgs.btop-cuda) else (pkgs.btop);
          settings = {
            shown_boxes = ''
              proc cpu mem net
            ''
            + lib.optionalString (config.btop-use-cuda) "gpu0 gpu1 gpu2 gpu3 gpu4 gpu5";
          };
        };
      };
    };
}
