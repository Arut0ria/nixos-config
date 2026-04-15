require("blink-cmp").setup({
  keymap = {preset = "default"},
  signature = {enabled = true},
  sources = {
    default = {"lsp", "path", "snippets", "buffer"},
  },
})
