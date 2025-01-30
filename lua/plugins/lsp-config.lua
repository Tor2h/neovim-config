return {
	"windwp/nvim-ts-autotag",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"angularls@17.3.5",
				"csharp_ls@8.0.405",
				"ts_ls",
				"html",
        "cssls",
			},
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			local project_library_path = "~/programming/BlueNoteWeb/webApp/angularapp/"

			local cmd = {
				"ngserver",
				"--stdio",
				"--tsProbeLocations",
				project_library_path,
				"--ngProbeLocations",
				project_library_path,
			}
			local util = require("lspconfig.util")

			require("lspconfig").angularls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = util.root_pattern("angular.json", ".git"),
        cmd = cmd,
				--cmd = {
					--"C:/Users/torho/programming/BlueNoteWeb/webApp/angularapp/node_modules/.bin/ngserver.cmd",
					--"--stdio",
					--"--tsProbeLocations",
					--"C:/Users/torho/programming/BlueNoteWeb/webApp/angularapp/node_modules/typescript/lib",
					--"--ngProbeLocations",
					--"C:/Users/torho/programming/BlueNoteWeb/webApp/angularapp/node_modules",
				--},
				on_new_config = function(new_config, new_root_dir)
          new_config.cmd = cmd
					--new_config.cmd = {
						--"C:/Users/torho/programming/BlueNoteWeb/webApp/angularapp/node_modules/.bin/ngserver.cmd",
						--"--stdio",
						--"--tsProbeLocations",
						--new_root_dir .. "/node_modules/typescript/lib",
						--"--ngProbeLocations",
						--new_root_dir .. "/node_modules",
					--}
				end,
			})

			local project_library_path_csharp = "~/programming/BlueNoteWeb/webApp/webapi"
			local cmd_csharp = {
				project_library_path_csharp,
			}
			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
			})

      lspconfig.cssls.setup({
        capabilities = capabilities,
      })

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"html",
				},
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
}
