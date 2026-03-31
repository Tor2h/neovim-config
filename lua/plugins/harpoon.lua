return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("harpoon").setup()
		end,
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "harpoon file",
			},
			{
				"<C-e>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "harpoon quick menu",
			},
			{
				"<A-m>",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "harpoon to file 1",
			},
			{
				"<A-,>",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "harpoon to file 2",
			},
			{
				"<A-.>",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "harpoon to file 3",
			},
			{
				"<A-j>",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "harpoon to file 4",
			},
			{
				"<A-k>",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "harpoon to file 5",
			},
			{
				"<A-l>",
				function()
					require("harpoon"):list():select(6)
				end,
				desc = "harpoon to file 6",
			},
			{
				"<A-u>",
				function()
					require("harpoon"):list():select(7)
				end,
				desc = "harpoon to file 7",
			},
			{
				"<A-i>",
				function()
					require("harpoon"):list():select(8)
				end,
				desc = "harpoon to file 8",
			},
			{
				"<A-o>",
				function()
					require("harpoon"):list():select(9)
				end,
				desc = "harpoon to file 9",
			},
		},
	},
}
