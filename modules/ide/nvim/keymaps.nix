[
  {
    mode = "n";
    key = "<leader><leader>";
    action = ":echo 'double leader'<CR>";
  }

  # Oil - File explorer
  {
    mode = "n";
    key = "<leader>o";
    action = "<cmd>Oil<CR>";
  }

  # Formatting
  {
    mode = [
      "n"
      "i"
    ];
    key = "<C-f>";
    action = "<cmd>lua require('conform').format()<CR>";
  }

  # Linter
  {
    mode = "n";
    key = "<leader>ll";
    action = "<cmd>lua require('lint').try_lint()<CR>";
  }

  # Git
  {
    mode = "n";
    key = "<leader>lg";
    action = "<cmd>LazyGit<CR>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "<leader>bl";
    action = "<cmd>Gitsigns blame_line<CR>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "]h";
    action = "<cmd>Gitsigns next_hunk<CR>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "[h";
    action = "<cmd>Gitsigns previous_hunk<CR>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "<leader>ph";
    action = "<cmd>Gitsigns preview_hunk<CR>";
    options.silent = true;
  }

  # LSP
  {
    mode = "n";
    key = "<gd>";
    action = "<cmd>lua vim.lsp.buf.definitions()<CR>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "<gr>";
    action = "<cmd>lua vim.lsp.buf.references()<CR>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "K";
    action = "<cmd>lua vim.lsp.buf.hover()<CR>";
    options.silent = true;
  }

  # Telescope
  {
    mode = "n";
    key = "<leader>fk";
    action = "<cmd>Telescope keymaps<CR>";
  }
  {
    mode = "n";
    key = "<leader>ff";
    action = "<cmd>Telescope find_files<CR>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "<leader>fg";
    action = "<cmd>Telescope live_grep<CR>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "<leader>fb";
    action = "<cmd>Telescope find_buffers<CR>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "<leader>fh";
    action = "<cmd>Telescope help_tags<CR>";
    options.silent = true;
  }

  # Others
  {
    mode = "n";
    key = "<leader>ex";
    action = "<cmd>Explore<CR>";
    options.silent = true;
  }
]
