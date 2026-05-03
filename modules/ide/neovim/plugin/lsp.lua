local servers = {
	nixd = {
		settings = {
			nixd = {
				nixpkgs = {
					expr = [[import <nixpkgs> {}]],
				},
				formatting = {
					command = { "nixfmt" },
				},
			},
		},
	},
	clangd = {},
	pyright = {
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
				},
			},
		},
	},
	ruff = {},
	ts_ls = {},
	cssls = {
		settings = {
			css = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
			scss = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
			less = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
		},
	},
	tailwindcss = {},
	astro = {},
	svelte = {
		settings = {
			Svelte = {
				compilerOptions = {
					runes = true,
				},
			},
		},
	},
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
			},
		},
	},
}

for server_name, cfg in pairs(servers) do
	vim.lsp.config(server_name, cfg)
	vim.lsp.enable(server_name)
end
