{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    btop-module.enable = lib.mkEnableOption "Enables Btop.";
    btop-module.useCuda = lib.mkOption {
      type = lib.types.bool;
      description = "Define if using cuda package version of btop.";
      default = false;
    };
  };

  config = lib.mkIf config.btop-module.enable {
    programs.btop = {
      enable = true;
      package = if (config.btop-module.useCuda) then (pkgs.btop-cuda) else (pkgs.btop);
      settings = {
        shown_boxes = ''
          proc cpu mem net
        ''
        + lib.optionalString (config.btop-module.useCuda) "gpu0 gpu1 gpu2 gpu3 gpu4 gpu5";
      };
    };
  };
}
