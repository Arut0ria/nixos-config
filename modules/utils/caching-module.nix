{config, lib, ...}:
let
  cfg = config.caching-module;
in
{
  options = {
    caching-module.enable = lib.mkEnableOption "Enables caching-module.";
  };

  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = [
        "https://cache.nixos-cuda.org"
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      ];
    };
  };
}