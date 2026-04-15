{ self, inputs, ... }:
{
  flake.nixosConfigurations.nixos-vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix

      self.nixosModules.me-module
      self.nixosModules.nixos-vm-configuration
      self.nixosModules.nixos-vm-home
    ];
  };
}
