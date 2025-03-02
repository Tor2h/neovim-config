return {
	"nvim-telescope/telescope-frecency.nvim",
	config = function()
			local function filenameFirst(_, path)
				local tail = vim.fs.basename(path)
				local parent = vim.fs.dirname(path)
				if parent == "." then
					return tail
				end
				return string.format("%s\t\t%s", tail, parent)
			end
		require("telescope").setup({
			extensions = {
				frecency = {
					show_scores = true,
          matcher = "fuzzy",
					show_filter_column = false,
					path_display = { "shorten" },
				},
			},
		})
		require("telescope").load_extension("frecency")
	end,
}
