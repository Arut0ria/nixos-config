{
  conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        nix = [ "nixfmt" ];
        python = [ "black" ];
        svelte = [
          "prettier"
        ];
        astro = [
          "prettier"
        ];
        "_" = [
          "squeeze_blank"
          "trim_whitespace"
          "trim_newlines"
        ];
      };

      default_format_opt = {
        lsp_format = "fallback";
      };

      format_on_save = {
        timeout_ms = 500;
      };

      format_after_save = {
        timeout_ms = 500;
      };

      log_level = "warn";
    };
  };
}
