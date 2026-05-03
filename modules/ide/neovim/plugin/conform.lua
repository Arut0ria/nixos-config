require("conform").setup({
	default_format_opt = { lsp_format = "fallback" },
	format_after_save = { lsp_format = "fallback" },
	format_on_save = { lsp_format = "fallback" },
	formatters_by_ft = {
		_ = { "squeeze_blank", "trim_whitespace", "trim_newlines" },
		astro = { "prettier" },
		nix = { "nixfmt" },
		python = { "ruff_organize_imports", "ruff_format" },
		svelte = { "prettier" },
		cpp = { "clang-format" },
		c = { "clang-format" },
		lua = { "stylua" },
	},
	log_level = vim.log.levels.WARN,
})
