require("conform").setup({
    default_format_opt = { lsp_format = "fallback" },
    format_after_save = { timeout_ms = 500 },
    format_on_save = { timeout_ms = 500 },
    formatters_by_ft = {
        _ = { "squeeze_blank", "trim_whitespace", "trim_newlines" },
        astro = { "prettier" },
        nix = { "nixfmt" },
        python = { "black" },
        svelte = { "prettier" },
    },
    log_level = vim.log.levels.WARN,
})
