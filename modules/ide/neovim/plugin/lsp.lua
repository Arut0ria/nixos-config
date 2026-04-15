local servers = {}

servers.nixd = {
  settings = {
    nixd = {
      nixpkgs = {
        expr = [[import <nixpkgs> {}]],
      },
      options = {
      },
      formatting = {
        command = { "nixfmt" }
      },
      diagnostic = {
        -- suppress = {
        --   "sema-escaping-with"
        -- }
      }
    }
  }
}

-- set up the servers to be loaded on the appropriate filetypes!
for server_name, cfg in pairs(servers) do
  vim.lsp.config(server_name, cfg)
  vim.lsp.enable(server_name)
end
