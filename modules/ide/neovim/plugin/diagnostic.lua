vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.HINT] = "󰌶",
      [vim.diagnostic.severity.INFO] = "󰋽",
    },
  },
  underline = true,
  update_in_insert = false,
  virtual_lines = { current_line = true },
  virtual_text = {
    prefix = function(diag)
      if diag.source then
        return "► " .. diag.source
      end
      return "►"
    end,
    spacing = 4,
  },
})
