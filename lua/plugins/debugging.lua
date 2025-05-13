return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		keys = {
			-- normal mode is default
			{
				"<leader>bt",
				function()
					require("dap").toggle_breakpoint()
				end,
			},
			{
				"<leader>bc",
				function()
					require("dap").continue()
				end,
			},
			{
				"<leader>bo",
				function()
					require("dap").step_over()
				end,
			},
			{
				"<leader>bi",
				function()
					require("dap").step_into()
				end,
			},
			-- {
			-- 	"<C-:>",
			-- 	function()
			-- 		require("dap").step_out()
			-- 	end,
			-- },
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()

			dap.adapters.chrome = {
				type = "executable",
				command = "node",
				args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapters/src/chromeDebug.ts" },
			}

			dap.configurations.javascript = {
				{
					type = "chrome",
					request = "attach",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}",
				},
			}

			dap.configurations.javascriptreact = {
				{
					type = "chrome",
					request = "attach",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}",
				},
			}

			dap.configurations.typescript = {
				{
					type = "chrome",
					request = "attach",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}",
				},
			}

			dap.configurations.typescriptreact = {
				{
					type = "chrome",
					request = "attach",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}",
				},
			}

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "npm",
					-- 💀 Make sure to update this path to point to your installation
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			-- dap.configurations.javascript = {
			-- 	{
			-- 		type = "pwa-node",
			-- 		request = "launch",
			-- 		name = "Launch file",
			-- 		program = "${file}",
			-- 		cwd = "${workspaceFolder}",
			-- 	},
			-- }
			--
			-- dap.configurations.typescript = {
			-- 	{
			-- 		type = "pwa-node",
			-- 		request = "launch",
			-- 		name = "Launch file",
			-- 		program = "${file}",
			-- 		cwd = "${workspaceFolder}",
			-- 	},
			-- }

			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "attach - netcoredbg",
					request = "attach",
					processId = function()
						local output = vim.fn.system(
							" ps aux | grep '[d]otnet ' | grep 'DOTNET_MODIFIABLE_ASSEMBLIES=debug' | awk '{print $2}'"
						)
						output = vim.trim(output)

						-- Debug output
						print("Process Output: ", output)

						local pid = tonumber(output)
						print("Process ID: ", pid)

						return pid
					end,
					-- program = function()
					-- 	local default_path = vim.fn.getcwd() .. "/bin/Debug/net9.0/webapi.dll"
					-- 	return vim.fn.input("Path to DLL: ", default_path, "file")
					-- end,
				},
			}

			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	ui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	ui.close()
			-- end
		end,
	},
}
