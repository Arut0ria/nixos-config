{ config, lib, pkgs, ... }: {
  options = {
    cava-module.enable = lib.mkEnableOption "Enables cava.";
  };

  config = lib.mkIf config.cava-module.enable {
    # stylix.targets.cava.rainbow.enable = lib.mkIf (builtins.hasAttr "stylix" args.inputs) true;

    programs.cava = {
      enable = true;
    };
  };
}
