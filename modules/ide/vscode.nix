{ pkgs, lib, config, ... }: {
  options = {
    vscode-module.enable = lib.mkEnableOption "Enables vscodium.";
  };

  config = lib.mkIf config.vscode-module.enable {
    # nixpkgs.config.allowUnfreePredicate = (pkg:
    #   builtins.elem (pkgs.lib.getName pkg) [
    #     "vscode-extension-MS-python-vscode-pylance"
    #   ]);

    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      package = pkgs.vscodium;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        arrterian.nix-env-selector
        ms-python.python
        rust-lang.rust-analyzer
        llvm-vs-code-extensions.vscode-clangd
        ms-toolsai.jupyter
        ms-python.black-formatter
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-tailwindcss";
          publisher = "bradlc";
          version = "0.14.21";
          sha256 = "TRc0RAhVZuvMHqmvNnDQlj1udslvQofxYvJnv/Ftp/g=";
        }
        {
          name = "ng-template";
          publisher = "angular";
          version = "19.0.3";
          sha256 = "0bnka51qj45r504isx47zvp20761i5qk232cc069r3ws6k1xfns1";
        }
        {
          name = "render-crlf";
          publisher = "medo64";
          version = "1.8.5";
          sha256 = "um9nAMECwf1vO5ASG9KbFTN6fFDWAW/3HdDvhqbO3WQ=";
        }
        {
          name = "vscode-glsllint";
          publisher = "dtoplak";
          version = "1.9.0";
          sha256 = "sha256-Ic5yCR9CIaYylw0wPSL7lgSk+2f2O/pYkWKGKJNwm0g=";
        }
        {
          name = "glsl-literal";
          publisher = "boyswan";
          version = "1.0.6";
          sha256 = "sha256-xprVNva0UOZBiCxxhnd71L+nLbtCbYfy4v6z8x685ck=";
        }
        {
          name = "shader";
          publisher = "slevesque";
          version = "1.1.5";
          sha256 = "sha256-Pf37FeQMNlv74f7LMz9+CKscF6UjTZ7ZpcaZFKtX2ZM=";
        }
        {
          name = "vscode-conventional-commits";
          publisher = "vivaxy";
          version = "1.26.0";
          sha256 = "sha256-Lj2+rlrKm9h21zEoXwa2TeGFNKBmlQKr7MRX0zgngdg=";
        }
        {
          name = "direnv";
          publisher = "mkhl";
          version = "0.17.0";
          sha256 = "sha256-9sFcfTMeLBGw2ET1snqQ6Uk//D/vcD9AVsZfnUNrWNg=";
        }
        {
          name = "basedpyright";
          publisher = "detachhead";
          version = "1.30.1";
          sha256 = "sha256-AHdMk3ANDxlKHVvm2UTet9381LwVQQ3+98Hz+22xkJ4=";
        }
      ];

      profiles.default.userSettings =
        let
          stylix-monospace = lib.optionalString ((builtins.hasAttr "stylix" config) && (config.stylix.enable)) ''${config.stylix.fonts.monospace.name}'';
          nerd-font = "JetBrainsMono Nerd Font Mono";
        in
        {
          "editor.fontFamily" = lib.mkForce "'${stylix-monospace}', '${nerd-font}'";
          "terminal.integrated.fontFamily" = lib.mkForce "";
          "editor.tabSize" = 2;
          "glsllint.glslangValidatorPath" = "glslang";
          "nix.formatterPath" = "nixpkgs-fmt";
          "editor.guides.indentation" = true;
        };
    };
  };
}
