return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " " },
			colored = true,
			update_in_insert = false,
			always_visible = true,
			cond = function()
				return vim.bo.filetype ~= "markdown"
			end,
		}

		local diff = {
			"diff",
			colored = true,
			symbols = { added = " ", modified = " ", removed = " " },
		}

		local mode = {
			"mode",
			fmt = function(str)
				return str
			end,
		}

		local branch = {
			"branch",
			icon = "",
		}

		local progress = function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local chars = { "", "", "" } --adding more chars will still work
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index] .. " " .. math.floor(line_ratio * 100) .. "%%"
		end

		local theme = require("kanagawa.colors").setup().theme

		local kanagawa = {}

		kanagawa.normal = {
			a = { bg = "#000000", fg = theme.syn.fun },
			b = { bg = "#000000", fg = theme.ui.bg },
			c = { bg = "#000000", fg = theme.ui.fg },
		}

		kanagawa.insert = {
			a = { bg = "#000000", fg = theme.diag.ok },
			b = { bg = "#000000", fg = theme.ui.bg },
		}

		kanagawa.command = {
			a = { bg = "#000000", fg = theme.syn.operator },
			b = { bg = "#000000", fg = theme.ui.bg },
		}

		kanagawa.visual = {
			a = { bg = "#000000", fg = theme.syn.keyword },
			b = { bg = "#000000", fg = theme.ui.bg },
		}

		kanagawa.replace = {
			a = { bg = "#000000", fg = theme.syn.constant },
			b = { bg = "#000000", fg = theme.ui.bg },
		}

		kanagawa.inactive = {
			a = { bg = "#000000", fg = theme.ui.fg_dim },
			b = { bg = "#000000", fg = theme.ui.fg_dim, gui = "bold" },
			c = { bg = "#000000", fg = theme.ui.fg_dim },
		}

		if vim.g.kanagawa_lualine_bold then
			for _, mode in pairs(kanagawa) do
				mode.a.gui = "bold"
			end
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = kanagawa,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				-- lualine_b = { branch, "filename" },
				lualine_b = { "filename" },
				lualine_c = { diff },
				lualine_x = { diagnostics, "filetype", "fileformat" },
				lualine_y = { "location" },
				lualine_z = { progress },
			},
			extensions = { "nvim-tree" },
		})
	end,
}
