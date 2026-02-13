lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	timeout = 1000,
}
lvim.leader = ","
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.adaptive_size = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.telescope.pickers.find_files.hidden = true
lvim.builtin.treesitter.auto_install = true
lvim.colorscheme = "kanagawa"

local prompts = {
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	Documentation = "Please provide documentation for the following code.",
	SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
	SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

lvim.plugins = {
	{ "gpanders/editorconfig.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		commit = "78ea7304b2ae851c09b61a3f694b13f171348970",
		-- branch = "canary", -- Use the canary branch if you want to test the latest features but it might be unstable
		-- version = "v2.11.0",
		-- Do not use branch and version together, either use branch or version
		dependencies = {
			{ "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			question_header = "## User ",
			answer_header = "## Copilot ",
			error_header = "## Error ",
			prompts = prompts,
			auto_follow_cursor = false, -- Don't follow the cursor after getting response
			show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
			mappings = {
				-- Use tab for completion
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				-- Close the chat
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				-- Reset the chat buffer
				reset = {
					normal = "<C-x>",
					insert = "<C-x>",
				},
				-- Submit the prompt to Copilot
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-CR>",
				},
				-- Accept the diff
				accept_diff = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				-- Yank the diff in the response to register
				yank_diff = {
					normal = "gmy",
				},
				-- Show the diff
				show_diff = {
					normal = "gmd",
				},
				-- Show the prompt
				show_system_prompt = {
					normal = "gmp",
				},
				-- Show the user selection
				show_user_selection = {
					normal = "gms",
				},
				-- Show help
				show_help = {
					normal = "gmh",
				},
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")
			-- Use unnamed register for the selection
			opts.selection = select.unnamed

			-- Override the git prompts message
			opts.prompts.Commit = {
				prompt = "Write commit message for the change with commitizen convention",
				selection = select.gitdiff,
			}
			opts.prompts.CommitStaged = {
				prompt = "Write commit message for the change with commitizen convention",
				selection = function(source)
					return select.gitdiff(source, true)
				end,
			}

			chat.setup(opts)
			-- Setup the CMP integration
			require("CopilotChat.integrations.cmp").setup()

			vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = "*", range = true })

			-- Inline chat with Copilot
			vim.api.nvim_create_user_command("CopilotChatInline", function(args)
				chat.ask(args.args, {
					selection = select.visual,
					window = {
						layout = "float",
						relative = "cursor",
						width = 1,
						height = 0.4,
						row = 1,
					},
				})
			end, { nargs = "*", range = true })

			-- Restore CopilotChatBuffer
			vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
				chat.ask(args.args, { selection = select.buffer })
			end, { nargs = "*", range = true })

			-- Custom buffer for CopilotChat
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-*",
				callback = function()
					vim.opt_local.relativenumber = true
					vim.opt_local.number = true

					-- Get current filetype and set it to markdown if the current filetype is copilot-chat
					local ft = vim.bo.filetype
					if ft == "copilot-chat" then
						vim.bo.filetype = "markdown"
					end
				end,
			})
		end,
		event = "VeryLazy",
		keys = {
			-- Show help actions with telescope
			{
				"<leader>ah",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "CopilotChat - Help actions",
			},
			-- Show prompts actions with telescope
			{
				"<leader>ap",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
			{
				"<leader>ap",
				":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
				mode = "x",
				desc = "CopilotChat - Prompt actions",
			},
			-- Code related commands
			{
				"<leader>ae",
				"<cmd>CopilotChatExplain<cr>",
				desc = "CopilotChat - Explain code",
			},
			{
				"<leader>at",
				"<cmd>CopilotChatTests<cr>",
				desc = "CopilotChat - Generate tests",
			},
			{
				"<leader>ar",
				"<cmd>CopilotChatReview<cr>",
				desc = "CopilotChat - Review code",
			},
			{
				"<leader>aR",
				"<cmd>CopilotChatRefactor<cr>",
				desc = "CopilotChat - Refactor code",
			},
			{
				"<leader>an",
				"<cmd>CopilotChatBetterNamings<cr>",
				desc = "CopilotChat - Better Naming",
			},
			-- Chat with Copilot in visual mode
			{
				"<leader>av",
				":CopilotChatVisual",
				mode = "x",
				desc = "CopilotChat - Open in vertical split",
			},
			{
				"<leader>ax",
				":CopilotChatInline<cr>",
				mode = "x",
				desc = "CopilotChat - Inline chat",
			},
			-- Custom input for CopilotChat
			{
				"<leader>ai",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
					end
				end,
				desc = "CopilotChat - Ask input",
			},
			-- Generate commit message based on the git diff
			{
				"<leader>am",
				"<cmd>CopilotChatCommit<cr>",
				desc = "CopilotChat - Generate commit message for all changes",
			},
			{
				"<leader>aM",
				"<cmd>CopilotChatCommitStaged<cr>",
				desc = "CopilotChat - Generate commit message for staged changes",
			},
			-- Quick chat with Copilot
			{
				"<leader>aq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						vim.cmd("CopilotChatBuffer " .. input)
					end
				end,
				desc = "CopilotChat - Quick chat",
			},
			{
				"<leader>ad",
				"<cmd>CopilotChatDebugInfo<cr>",
				desc = "CopilotChat - Debug Info",
			},
			{
				"<leader>af",
				"<cmd>CopilotChatFixDiagnostic<cr>",
				desc = "CopilotChat - Fix Diagnostic",
			},
			{
				"<leader>al",
				"<cmd>CopilotChatReset<cr>",
				desc = "CopilotChat - Clear buffer and chat history",
			},
			{
				"<leader>av",
				"<cmd>CopilotChatToggle<cr>",
				desc = "CopilotChat - Toggle",
			},
			{
				"<leader>a?",
				"<cmd>CopilotChatModels<cr>",
				desc = "CopilotChat - Select Models",
			},
		},
	},
	{
		"vim-test/vim-test",
		keys = {
			{ "<leader>t", "", desc = "+test" },
			{
				"<leader>tt",
				"<cmd>TestFile<cr>",
				desc = "Run File (vim-test)",
			},
			{
				"<leader>tT",
				"<cmd>TestSuite<cr>",
				desc = "Run All Test Files (vim-test)",
			},
			{
				"<leader>tr",
				"<cmd>TestNearest<cr>",
				desc = "Run Nearest (vim-test)",
			},
			{
				"<leader>tl",
				"<cmd>TestLast<cr>",
				desc = "Run Last (vim-test)",
			},
			{
				"<leader>tv",
				"<cmd>TestVisit<cr>",
				desc = "Visit Test (vim-test)",
			},
		},
		config = function()
			vim.g["test#strategy"] = "neovim"
		end,
	},
}

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		command = "eslint_d",
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescriptreact",
			"typescript",
		},
	},
	{
		command = "prettier",
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"css",
			"scss",
			"html",
			"json",
			"yaml",
			"less",
			"markdown",
			"graphql",
		},
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "eslint_d",
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescriptreact",
			"typescript",
		},
	},
	{
		command = "stylelint",
		filetypes = {
			"css",
			"scss",
			"less",
			"sass",
		},
	},
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		command = "eslint_d",
		args = { "-f" },
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescriptreact",
			"typescript",
		},
	},
})

require("lvim.lsp.manager").setup("cssls", {
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		less = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
})

require("gitsigns").setup()

require("copilot").setup({
	panel = {
		enabled = false,
	},
	suggestion = {
		enabled = false,
	},
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	copilot_node_command = "node", -- Node.js version must be > 18.x
	server_opts_overrides = {},
})

-- Custom stylelint auto-fix on save
local stylelint_augroup = vim.api.nvim_create_augroup("StylelintAutofix", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = stylelint_augroup,
	pattern = { "*.css", "*.scss", "*.less", "*.sass" },
	callback = function()
		local filepath = vim.api.nvim_buf_get_name(0)

		-- Skip if file doesn't exist
		if filepath == "" or vim.fn.filereadable(filepath) == 0 then
			return
		end

		-- Run stylelint --fix on the file
		local cmd = string.format("stylelint --fix %s 2>&1", vim.fn.shellescape(filepath))
		local output = vim.fn.system(cmd)
		local exit_code = vim.v.shell_error

		-- Debug: uncomment to see output
		-- print("Stylelint exit code:", exit_code)
		-- if exit_code ~= 0 then print("Stylelint output:", output) end

		-- Reload the buffer if stylelint made changes (exit code 0 or 2)
		-- Exit code 2 means there were unfixable errors but fixes were applied
		if exit_code == 0 or exit_code == 2 then
			vim.cmd("silent! checktime")
		end
	end,
})
