-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{'neoclide/coc.nvim', branch = 'release'},
	'tikhomirov/vim-glsl',
	{"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {}
		end,
	},
	{"cdelledonne/vim-cmake"},
	{"github/copilot.vim"},
	{'voldikss/vim-mma'},
	{
		"lervag/vimtex",
		lazy = false,     -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_general_viewer = 'okular'
			vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
		end
	},
	{"OmniSharp/omnisharp-vim"}
}
