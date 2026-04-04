return {
	"MeanderingProgrammer/render-markdown.nvim",
	-- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		ignore = function(buffer)
			if vim.bo[buffer].buftype ~= "nofile" then
				return false
			end

			for _, win in ipairs(vim.fn.win_findbuf(buffer)) do
				if vim.api.nvim_win_get_config(win).relative ~= "" then
					return true
				end
			end

			return false
		end,
	},
}
