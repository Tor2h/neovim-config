return {
	-- {
	-- 	"echasnovski/mini.animate",
	-- 	config = function()
	-- 		require("mini.animate").setup({
	--        scroll = {
	--          enable = false
	--        }
	--      })
	-- 	end,
	-- },
	{
		"echasnovski/mini.tabline",
		config = function()
			require("mini.tabline").setup({
				set_vim_settings = false,
			})
		end,
	},
	{
		"echasnovski/mini.notify",
		config = function()
			require("mini.notify").setup()
		end,
	},
	{
		"echasnovski/mini.cursorword",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
}
