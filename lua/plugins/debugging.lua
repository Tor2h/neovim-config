return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			{
				"microsoft/vscode-js-debug",
				version = "1.x",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
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
			require("vscode-js-debug").setup({})

			require("dapui").setup()
			require("dap-vscode-js").setup({
				-- debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			require("nvim-dap-virtual-text").setup({
				-- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
				display_callback = function(variable)
					local name = string.lower(variable.name)
					local value = string.lower(variable.value)
					if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
						return "*****"
					end

					if #variable.value > 15 then
						return " " .. string.sub(variable.value, 1, 15) .. "... "
					end

					return " " .. variable.value
				end,
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end

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
	-- {
	-- 	"nicholasmata/nvim-dap-cs",
	-- 	config = function()
	-- 		require("dap-cs").setup({
	-- 			dap_configurations = {
	-- 				-- Must be "coreclr" or it will be ignored by the plugin
	-- 				type = "coreclr",
	-- 				name = "Attach remote",
	-- 				mode = "remote",
	-- 				request = "attach",
	-- 			},
	-- 			netcoredbg = {
	-- 				-- the path to the executable netcoredbg which will be used for debugging.
	-- 				-- by default, this is the "netcoredbg" executable on your PATH.
	-- 				path = "netcoredbg",
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
