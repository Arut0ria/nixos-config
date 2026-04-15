require("catppuccin").setup({
    flavour = "mocha",
    integrations = {
        indent_blankline = { enabled = true },
        native_lsp = { enabled = true },
        telescope = { enabled = true },
        treesitter = true,
    },
    transparent_background = true,
})

-- Définir la variable d'environnement
vim.env.BAT_THEME = 'catppuccin-mocha'

-- Appliquer le thème
vim.cmd.colorscheme("catppuccin-mocha")
