return {
	"windwp/nvim-ts-autotag",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				registries = {
					"github:Crashdummyy/mason-registry",
					"github:mason-org/mason-registry",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"angularls@17.3.5",
				"ts_ls",
				"html",
				"cssls",
			},
			auto_install = true,
		},
	},
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		opts = {
			config = {
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentFormattingRangeProvider = false
				end,
			},
			-- your configuration comes here; leave empty for default settings
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach_no_format = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentFormattingRangeProvider = false
			end

			local work_angular_path = "C:/Projekter/renomatic/Angular/renomatic"
			local work_config_path = "C:/Users/tho/AppData/Local/nvim"
			local personal_angular_path = "C:/Users/Tor/programming/BlueNoteWeb/webApp/angularapp"
			local personal_config_path = "C:/Users/Tor/AppData/Local/nvim"

			local current_dir = vim.fn.getcwd():gsub("\\", "/")
			local current_config_dir = vim.fn.stdpath("config"):gsub("\\", "/")

			if current_dir == personal_angular_path then
				require("lspconfig").angularls.setup({
					on_attach = function(client)
						on_attach_no_format(client)
					end,
					capabilities = capabilities,
					root_dir = require("lspconfig").util.root_pattern("angular.json", ".git"),
					cmd = {
						"C:/Users/Tor/programming/BlueNoteWeb/webApp/angularapp/node_modules/.bin/ngserver.cmd",
						"--stdio",
						"--tsProbeLocations",
						"C:/Users/Tor/programming/BlueNoteWeb/webApp/angularapp/node_modules/typescript/lib",
						"--ngProbeLocations",
						"C:/Users/Tor/programming/BlueNoteWeb/webApp/angularapp/node_modules",
					},
					on_new_config = function(new_config, new_root_dir)
						new_config.cmd = {
							"C:/Users/Tor/programming/BlueNoteWeb/webApp/angularapp/node_modules/.bin/ngserver.cmd",
							"--stdio",
							"--tsProbeLocations",
							new_root_dir .. "/node_modules/typescript/lib",
							"--ngProbeLocations",
							new_root_dir .. "/node_modules",
						}
					end,
				})
			end

			if current_config_dir == work_config_path then
				local project_library_path = "C:/Projekter/renomatic/Angular/renomatic/"
				local cmd = {
					"ngserver",
					"--stdio",
					"--tsProbeLocations",
					project_library_path,
					"--ngProbeLocations",
					project_library_path,
				}
				require("lspconfig").angularls.setup({
					on_attach = function(client)
						on_attach_no_format(client)
					end,
					capabilities = capabilities,
					root_dir = require("lspconfig").util.root_pattern("angular.json", ".git"),
					cmd = cmd,
					on_new_config = function(new_config, new_root_dir)
						new_config.cmd = cmd
					end,
				})
			end

			local util = require("lspconfig.util")

			-- if current_config_dir == work_config_path then
			-- 	lspconfig.csharp_ls.setup({
			-- 		on_attach = function(client)
			-- 			on_attach_no_format(client)
			-- 		end,
			-- 		capabilities = capabilities,
			-- 		root_dir = "C:/Projekter/renomatic/Renomatic_Codebase/Renomatic.Core/",
			-- 	})
			-- end

			if current_config_dir == personal_config_path then
				lspconfig.csharp_ls.setup({
					on_attach = function(client)
						on_attach_no_format(client)
					end,
					capabilities = capabilities,
					root_dir = "~/programming/BlueNoteWeb/webApp/webapi",
				})
			end

			lspconfig.html.setup({
				on_attach = function(client)
					on_attach_no_format(client)
				end,
				capabilities = capabilities,
			})

			lspconfig.cssls.setup({
				on_attach = function(client)
					on_attach_no_format(client)
				end,
				capabilities = capabilities,
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = function(client)
					on_attach_no_format(client)
				end,
			})

			if current_config_dir == personal_config_path then
				lspconfig.ts_ls.setup({
					on_attach = function(client)
						on_attach_no_format(client)
					end,
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

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Definition" })
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
			vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Declaration" })
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Implementation" })
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Definition" })
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("typescript-tools").setup({
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			})
		end,
	},
}
