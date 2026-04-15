local map = vim.keymap.set
local opts = { silent = true }

-- Général
-- map("n", "<leader><leader>", ":echo 'double leader'<CR>")
map("n", "<leader>o", "<cmd>Oil<CR>")
map({ "n", "i" }, "<C-f>", function() require("conform").format() end)

-- Lint
map("n", "<leader>ll", function() require("lint").try_lint() end)

-- Git
map("n", "<leader>lg", "<cmd>LazyGit<CR>", opts)
map("n", "<leader>bl", "<cmd>Gitsigns blame_line<CR>", opts)
map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", opts)
map("n", "[h", "<cmd>Gitsigns previous_hunk<CR>", opts)
map("n", "<leader>ph", "<cmd>Gitsigns preview_hunk<CR>", opts)

-- LSP
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "K", vim.lsp.buf.hover, opts)

-- Telescope
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>")
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<leader>fb", "<cmd>Telescope find_buffers<CR>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

-- File Explorer
map("n", "<leader>ex", "<cmd>Explore<CR>", opts)
