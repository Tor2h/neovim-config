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

			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.typescript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input(vim.fn.getcwd():gsub("\\", "/"), vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
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
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
