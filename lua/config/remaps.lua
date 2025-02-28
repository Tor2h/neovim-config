local set = vim.keymap.set
local k = vim.keycode
local opts = { noremap = true, silent = true }

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("x", "<leader>p", '"_dP')

set("n", "<leader>y", '"+y')
set("v", "<leader>y", '"+y')

set("v", "<leader>d", '"_d')
set("n", "<leader>d", '"_d')

set("n", "<leader>i", "<C-]>", opts)

set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

set("n", "<leader>s", ":wa<CR>")

-- set("n", "<c-w>j", "<c-w><c-j>")
-- set("n", "<c-w>k", "<c-w><c-k>")
-- set("n", "<c-w>l", "<c-w><c-l>")
-- set("n", "<c-w>h", "<c-w><c-h>")

set("n", "<leader>te", ":tabedit<CR>", opts)
set("n", "<left>", "gT")
set("n", "<right>", "gt")

set("n", "<leader>x", vim.diagnostic.open_float, { desc = "Error diagnostic" })

set("n", "<leader>ge", vim.diagnostic.goto_next, { desc = "Next Error" })

set("n", "<CR>", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.v.hlsearch == 1 then
		vim.cmd.nohl()
		return ""
	else
		return k("<CR>")
	end
end, { expr = true })
