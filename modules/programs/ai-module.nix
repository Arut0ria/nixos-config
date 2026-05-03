{ inputs, moduleWithSystem, ... }:
{
  flake.nixosModules.ai-module = moduleWithSystem (
    perSystem@{ system, ... }:
    nixos@{ pkgs, ... }:
    let
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      config = {
        nixpkgs.overlays = [
          (final: prev: {
            ollama = pkgs-unstable.ollama;
            opencode = pkgs-unstable.opencode;
            llama-cpp = pkgs-unstable.llama-cpp;
          })
        ];

        environment.systemPackages = with pkgs; [
          (pkgs.ollama.override {
            acceleration = "cuda";
          })
          (pkgs.llama-cpp.override {
            cudaSupport = true;
          })
          opencode
        ];
      };
    }
  );
}
