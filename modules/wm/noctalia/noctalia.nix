{ inputs, self, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    let
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
    in
    {
      packages.noctalia = inputs.nix-wrappers-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        package = pkgs-unstable.noctalia-shell;
        imports = [ self.wrapperModules.noctalia-config ];
      };
    };
}
