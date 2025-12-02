{ lib, config, ... }: {
  options = {
    pipewire-module.enable = lib.mkEnableOption "Enables pipewire.";
  };

  config = lib.mkIf config.pipewire-module.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
