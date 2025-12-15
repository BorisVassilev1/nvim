-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{ 'neoclide/coc.nvim',    branch = 'release' },
	'tikhomirov/vim-glsl',
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {}
		end,
	},
	{ "cdelledonne/vim-cmake" },
	{ "github/copilot.vim" },
	{ 'voldikss/vim-mma' },
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_general_viewer = 'okular'
			vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
		end
	},
	{ "OmniSharp/omnisharp-vim" },
	{ 'mfussenegger/nvim-dap' },
	{
		"R-nvim/R.nvim",
		-- Only required if you also set defaults.lazy = true
		lazy = false,
		-- R.nvim is still young and we may make some breaking changes from time
		-- to time (but also bug fixes all the time). If configuration stability
		-- is a high priority for you, pin to the latest minor version, but unpin
		-- it and try the latest version before reporting an issue:
		-- version = "~0.1.0"
		config = function()
			-- Create a table with the options to be passed to setup()
			---@type RConfigUserOpts
			local opts = {
				hook = {
					on_filetype = function()
						vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
						vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
					end
				},
				R_args = { "--quiet", "--no-save" },
				min_editor_width = 72,
				rconsole_width = 78,
				objbr_mappings = {                   -- Object browser keymap
					c = 'class',                     -- Call R functions
					['<localleader>gg'] = 'head({object}, n = 15)', -- Use {object} notation to write arbitrary R code.
					v = function()
						-- Run lua functions
						require('r.browser').toggle_view()
					end
				},
				disable_cmds = {
					"RClearConsole",
					"RCustomStart",
					"RSPlot",
					"RSaveClose",
				},
			}
			-- Check if the environment variable "R_AUTO_START" exists.
			-- If using fish shell, you could put in your config.fish:
			-- alias r "R_AUTO_START=true nvim"
			if vim.env.R_AUTO_START == "true" then
				opts.auto_start = "on startup"
				opts.objbr_auto_start = true
			end
			require("r").setup(opts)
		end,
	},
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	}

}
