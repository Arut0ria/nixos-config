{
  lint = {
    enable = true;
    lintersByFt = {
      nix = [
        "nix"
        # "deadnix"
      ];
      javascript = [
        "eslint_d"
      ];
      typescript = [
        "eslint_d"
      ];
    };
  };
}
