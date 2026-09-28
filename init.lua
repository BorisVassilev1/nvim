--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- nvim-tree replaces netrw; disable it before any plugin loads (see `:help nvim-tree-netrw`)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  --'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- { -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },
  { "catppuccin/nvim",      name = "catppuccin" },
  { 'kkoomen/vim-doge',     run = 'call doge#install()' },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    },
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.colorcolumn = "120"

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'

vim.cmd.colorscheme "catppuccin-mocha"
vim.opt.cursorline = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<C-j>', '5j', { silent = true })
vim.keymap.set('n', '<C-k>', '5k', { silent = true })
vim.keymap.set('n', '<Leader>!', ':source%<CR>')

vim.keymap.set({ 'n', 'v', 'i' }, '<A-h>', '<C-w>h');
vim.keymap.set({ 'n', 'v', 'i' }, '<A-l>', '<C-w>l');
vim.keymap.set({ 'n', 'v', 'i' }, '<A-j>', '<C-w>j');
vim.keymap.set({ 'n', 'v', 'i' }, '<A-k>', '<C-w>k');

vim.keymap.set({ 'n', 'v', 'i' }, '<M-i>', ':NvimTreeToggle<CR>', { silent = true });

vim.keymap.set({'n'}, '<M-T>', ':CsvViewToggle delimiter=\t display_mode=border<CR>', { silent = true });
--vim.keymap.set({'n'}, '<Leader>csv', ':CsvViewToggle delimiter=, display_mode=border<CR>', { silent = true });

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sF', require('telescope.builtin').git_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter` and `:help treesitter`
-- Add languages to be installed here that you want installed for treesitter (no-op if already installed)
require('nvim-treesitter').install {
  'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'javascript', 'html', 'hlsl', 'vimdoc', 'vim',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    -- Highlighting (fails silently when there is no parser for the filetype)
    if not pcall(vim.treesitter.start, args.buf) then
      return
    end
    -- Indentation (experimental)
    local lang = vim.treesitter.language.get_lang(args.match)
    if args.match ~= 'python' and lang and vim.treesitter.query.get(lang, 'indents') then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Incremental selection: built into nvim 0.12 as `an` (parent node) / `in` (child node) in visual mode
vim.keymap.set('n', '<c-space>', 'van', { remap = true, desc = 'Start treesitter node selection' })
vim.keymap.set('x', '<c-space>', 'an', { remap = true, desc = 'Expand selection to parent node' })
vim.keymap.set('x', '<M-space>', 'in', { remap = true, desc = 'Shrink selection to child node' })

-- [[ Configure Treesitter textobjects ]] (main branch API)
require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
  },
  move = {
    set_jumps = true, -- whether to set jumps in the jumplist
  },
}

do
  local select = require('nvim-treesitter-textobjects.select')
  local move = require('nvim-treesitter-textobjects.move')
  local swap = require('nvim-treesitter-textobjects.swap')

  -- You can use the capture groups defined in textobjects.scm
  for keys, query in pairs {
    ['aa'] = '@parameter.outer',
    ['ia'] = '@parameter.inner',
    ['af'] = '@function.outer',
    ['if'] = '@function.inner',
    ['ac'] = '@class.outer',
    ['ic'] = '@class.inner',
  } do
    vim.keymap.set({ 'x', 'o' }, keys, function()
      select.select_textobject(query, 'textobjects')
    end, { desc = 'Select textobject ' .. query })
  end

  for fn, maps in pairs {
    goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
    goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
    goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
    goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
  } do
    for keys, query in pairs(maps) do
      vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
        move[fn](query, 'textobjects')
      end, { desc = fn .. ' ' .. query })
    end
  end

  vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner') end, { desc = 'Swap next parameter' })
  vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end, { desc = 'Swap previous parameter' })
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

require('plugins/coc_setup')

-- Filetype

vim.cmd("autocmd BufNewFile,BufRead *.fh :set ft=glsl")
vim.cmd("autocmd BufNewFile,BufRead *.fx :set ft=glsl")
vim.cmd("autocmd FileType scheme map <buffer> <F9> :w<CR>:exec '!racket %'<CR>")
vim.cmd("autocmd BufNewFile,BufRead *.fs :set ft=glsl")
vim.cmd("autocmd BufNewFile,BufRead *.vs :set ft=glsl")
vim.cmd("autocmd BufNewFile,BufRead *.hlsl :set ft=hlsl")


vim.cmd("autocmd BufNewFile,BufRead *.pl :set ft=prolog")
vim.cmd("autocmd BufNewFile,BufRead *.cm :set ft=cm")

local function open_my_terminal(cmd)
  vim.api.nvim_command("below split")
  vim.api.nvim_command("terminal "..cmd)
  vim.o.modified = false
  vim.o.bufhidden = "delete"
  vim.o.modifiable = true
  vim.keymap.set({'n', 'v', 'i'}, 'q', ":q<CR>", {buffer = vim.api.nvim_get_current_buf()})
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "haskell",
  callback = function()
    vim.keymap.set('n', '<F5>', function()
      open_my_terminal("runghc-9.8 %")
    end, { desc = "run file" })
    vim.opt.expandtab = true
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    local cmd = "clang++ \"%\" -Wall -Wextra -std=c++20 -fsanitize=address,undefined -g"
    vim.keymap.set('n', '<F5>', function()
      open_my_terminal("echo compiling && "..cmd.." && echo running && ./a.out")
    end, { desc = "compile and run file" })
    vim.keymap.set('n', '<F17>', function()
      open_my_terminal("echo compiling && "..cmd.." && echo done")
    end, { desc = "compile file" })
    vim.keymap.set('n', '<F29>', function()
      open_my_terminal("echo running && ./a.out")
    end, { desc = "run file" })
    vim.keymap.set('n', '<F6>', function()
      open_my_terminal("make > /dev/null && ./a.out")
    end, {desc="make"})

    --vim.opt.makeprg = "cmake --build build -j8"
    vim.keymap.set("n", "<F4>", ":AsyncRun cmake --build build -j8<CR>", { silent = true })
    vim.keymap.set("n", "<leader>q", ":copen<CR>")
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    local cmd = "cc \"%\" -Wall -Wextra --pedantic-errors -fsanitize=address -g"
    vim.keymap.set('n', '<F5>', function()
      open_my_terminal("echo compiling && "..cmd.." && echo running && ./a.out")
    end, { desc = "compile and run file" })
    vim.keymap.set('n', '<F17>', function()
      open_my_terminal("echo compiling && "..cmd.." && echo done")
    end, { desc = "compile file" })
    vim.keymap.set('n', '<F29>', function()
      open_my_terminal("echo running && ./a.out")
    end, { desc = "run file" })
  end
})

-- vim.g.OmniSharp_server_stdio = 0
-- vim.g.OmniSharp_highlighting = 0
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = "mma",
  callback = function()
    local cmd = "wolfram -script \"%\""
    vim.keymap.set('n', '<F5>', function()
      open_my_terminal("echo running && "..cmd.." && echo done")
    end, { desc = "run Wolfram file" })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "prolog",
  callback = function()
    local cmd = "swipl \"%\""
    vim.keymap.set('n', '<F5>', function()
      open_my_terminal("echo running && "..cmd.." && echo done")
    end, { desc = "run Wolfram file" })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    local cmd = "python3 \"%\""
    vim.keymap.set('n', '<F5>', function()
      open_my_terminal("echo running && "..cmd.." && echo done")
    end, { desc = "run Python file" })
  end
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cm = {
  install_info = {
    url = "~/Documents/tree-sitter-cm",
    files = { "src/parser.c" },
    generate_reqires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "cm",
  used_by = { "cm" },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
