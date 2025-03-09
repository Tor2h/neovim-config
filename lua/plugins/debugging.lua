return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- dap.adapters.coreclr = {
			-- 	type = "executable",
			-- 	command = "~/scoop/apps/netcoredbg/",
			-- 	args = { "--interpreter=vscode" },
			-- }
			--
			-- dap.configurations.cs = {
			-- 	{
			-- 		type = "coreclr",
			-- 		name = "launch - netcoredbg",
			-- 		request = "launch",
			-- 		program = function()
			-- 			return vim.fn.input("~/scoop/apps/netcoredbg/", vim.fn.getcwd() .. "/bin/Debug/", "file")
			-- 		end,
			-- 	},
			-- }

			require("dap-go").setup()
			require("dapui").setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>bg", dapui.toggle, { desc = "Toggle dapui" })
			vim.keymap.set("n", "<Leader>bt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>bc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>bo", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>bi", dap.step_into, { desc = "Step into" })
		end,
	},
	{
		"nicholasmata/nvim-dap-cs",
		config = function()
			require("dap-cs").setup({
				dap_configurations = {
					-- Must be "coreclr" or it will be ignored by the plugin
					type = "coreclr",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
				netcoredbg = {
					-- the path to the executable netcoredbg which will be used for debugging.
					-- by default, this is the "netcoredbg" executable on your PATH.
					path = "netcoredbg",
				},
			})
		end,
	},
}
