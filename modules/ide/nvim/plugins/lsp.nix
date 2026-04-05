{
  lsp = {
    enable = true;
    servers = {
      nixd = {
        enable = true;
      };
      astro.enable = true;
      svelte.enable = true;
      ts_ls.enable = true;
      clangd.enable = true;
    };
  };
}
