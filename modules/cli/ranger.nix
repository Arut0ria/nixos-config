{ pkgs, config, lib, ... }: {
  options = {
    ranger-module.enable = lib.mkEnableOption "Enables Ranger";
  };

  config = lib.mkIf config.ranger-module.enable {
    programs.ranger = {
      enable = true;
      settings = {
        preview_images_method = lib.optionals (config.kitty-module.enable) "kitty";
      };
    };
  };
}
