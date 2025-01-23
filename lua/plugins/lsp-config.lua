return {
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
                "ts_ls@5.7.4",
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
--ngserver --ngProbeLocations "~/node_modules" --tsProbeLocations ~/node_modules
				"ngserver",
				"--stdio",
				"--tsProbeLocations",
                "~/node_modules",
--				project_library_path,
				"--ngProbeLocations",
                "~/node_modules",
--				project_library_path,
			}

			local util = require("lspconfig.util")

			lspconfig.angularls.setup({
				cmd = cmd,
				on_new_config = function(new_config, project_library_path)
					new_config.cmd = cmd
				end,
                filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
				on_attach = on_attach,
				root_dir = util.root_pattern(".git", "angular.json", "project.json"),
				capabilities = capabilities,
			})

			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
