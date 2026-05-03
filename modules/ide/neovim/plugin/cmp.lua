require("blink-cmp").setup({
  keymap = {preset = "enter"},
  signature = {enabled = true},
  sources = {
    default = {"lsp", "path", "snippets", "buffer"},
  },
})
