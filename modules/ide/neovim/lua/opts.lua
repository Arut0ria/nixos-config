local g = vim.g
local o = vim.opt

g.mapleader = ' '
g.maplocalleader = ' '

o.relativenumber = true
o.number = true
o.clipboard = "unnamedplus"
o.wrap = false;
o.termguicolors = true
o.colorcolumn = "80"
o.encoding = "utf-8"

-- Scroll
o.scrolloff = 10
o.scroll = 6

-- Tab
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = -1
o.shiftround = true
o.expandtab = true
o.smartindent = true
