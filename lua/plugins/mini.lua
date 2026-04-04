return {
	{
		"echasnovski/mini.sessions",
		config = function()
			require("mini.sessions").setup({
				version = false,
			})
		end,
	},
	{
		"echasnovski/mini.pairs",
		config = function()
			require("mini.pairs").setup({
				version = false,
			})
		end,
	},
}
