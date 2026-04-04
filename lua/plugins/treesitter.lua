local M = {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
		require("nvim-treesitter.parsers").get_parser_configs().html = {
			install_info = {
				url = "https://github.com/tree-sitter/tree-sitter-html",
				files = { "src/parser.c", "src/scanner.cc" },
			},
			filetype = "html",
		}
	end,
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"c_sharp",
				"html",
				"javascript",
				"markdown",
				"markdown_inline",
				"typescript",
				"tsx",
				"css",
				"rust",
				"typst",
			},
			auto_install = true,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
		})
		require("ts_context_commentstring").setup({
			enable = true,
			enable_autocmd = false,
		})
	end,
}

return { M }
