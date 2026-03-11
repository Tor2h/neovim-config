return {
	{
		"echasnovski/mini.ai",
		config = function()
			require("mini.ai").setup({
				version = false,
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup({
				version = false,
			})
		end,
	},
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
	-- {
	-- 	"echasnovski/mini.statusline",
	-- 	config = function()
	-- 		require("mini.statusline").setup({
	-- 			version = false,
	-- 		})
	-- 	end,
	-- },
}
