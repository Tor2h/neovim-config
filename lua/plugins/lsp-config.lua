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
				"csharp_ls",
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

			local machine = "pc"
			local lspconfig = require("lspconfig")

			--https://www.reddit.com/r/neovim/comments/1b2agh3/configure_auto_formatting_for_none_ls_and/

			local project_library_path = "~/programming/BlueNoteWeb/webApp/angularapp/"
			local cmd = {
				"C:/Users/Tor/programming/BlueNoteWeb/webApp/angularapp/node_modules/.bin/ngserver.cmd",
				"--stdio",
				"--tsProbeLocations",
				"C:/Users/Tor/programming/BlueNoteWeb/webApp/angularapp/node_modules/typescript/lib",
				"--ngProbeLocations",
				"C:/Users/Tor/programming/BlueNoteWeb/webApp/angularapp/node_modules",
			}
			local project_library_path_csharp = "~/programming/BlueNoteWeb/webApp/webapi"

			if machine == "work" then
				project_library_path = "C:/Projekter/renomatic/Angular/renomatic/"
				cmd = {
					"ngserver",
					"--stdio",
					"--tsProbeLocations",
					project_library_path,
					"--ngProbeLocations",
					project_library_path,
				}
				project_library_path_csharp = "C:/Projekter/renomatic/Renomatic_Codebase/Renomatic.Core/"
			end

			local util = require("lspconfig.util")

			require("lspconfig").angularls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = require("lspconfig").util.root_pattern("angular.json", ".git"),
				cmd = cmd,
				on_new_config = function(new_config, new_root_dir)
					new_config.cmd = cmd
					if machine == "pc" then
						new_config.cmd = {
							"C:/Users/Tor/programming/BlueNoteWeb/webApp/angularapp/node_modules/.bin/ngserver.cmd",
							"--stdio",
							"--tsProbeLocations",
							new_root_dir .. "/node_modules/typescript/lib",
							"--ngProbeLocations",
							new_root_dir .. "/node_modules",
						}
					end
				end,
			})

			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
				root_dir = project_library_path_csharp,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			if machine == "pc" then
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
			end

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {})
		end,
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {},
	-- },
}
