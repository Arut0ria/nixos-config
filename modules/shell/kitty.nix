{ lib, config, ... }: {
  options = {
    kitty-module.enable = lib.mkEnableOption "Enables kitty.";
  };

  config = lib.mkIf config.kitty-module.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = (lib.mkIf (config.zsh-module.enable) true);
    };
  };
}
