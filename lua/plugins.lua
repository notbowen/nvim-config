local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Taken from: https://gist.github.com/sstark/6b0debeab9e23bf2d198a8aa7e9c0c51
local gruvbox = {
    fg = '#928374',
    bg = '#1F2223',
    black ='#1B1B1B',
    skyblue = '#458588',
    cyan = '#83a597',
    green = '#689d6a',
    oceanblue = '#1d2021',
    magenta = '#fb4934',
    orange = '#fabd2f',
    red = '#cc241d',
    violet = '#b16286',
    white = '#ebdbb2',
    yellow = '#d79921',
}

require("lazy").setup({
    -- Theme
    "ellisonleao/gruvbox.nvim",
    -- VSCode Pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" }
    },
    -- Auto Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
			"lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
		},
		config = function()
			require("config.nvim-cmp")
		end,
    },
    -- Code snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},
    -- LSP
    "williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
    -- Icons
    "nvim-tree/nvim-web-devicons",
    -- File Explorer
    {
        "SidOfc/carbon.nvim",
        config = function ()
            require("carbon").setup()
        end
    },
    -- Surround with Brackets
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    -- Discord flex
    {
        "andweeb/presence.nvim",
        config = function ()
            require("presence").setup({
                -- General options
                auto_update         = true,                   
                neovim_image_text   = "Sneaky secks",         
                main_image          = "neovim",               
                -- client_id           = "793271441293967371",
                log_level           = nil,                    
                debounce_timeout    = 10,                     
                enable_line_number  = false,                  
                blacklist           = {},                     
                buttons             = true,                   
                file_assets         = {},                     
                show_time           = true,                   

                -- Rich Presence text options
                editing_text        = "Editing %s",           
                file_explorer_text  = "Browsing %s",          
                git_commit_text     = "Committing changes",   
                plugin_manager_text = "Managing plugins",     
                reading_text        = "Reading %s",           
                workspace_text      = "Working on %s",        
                line_number_text    = "Line %s out of %s",    
            })
        end
    },
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ':TSUpdate',
        event = { 'BufRead' },
        config = function ()
            require('nvim-treesitter.configs').setup({
                indent = { enable = true },
                highlight = { enable = true },
                ensure_installed = {
                  'c',
                  'cpp',
                  'css',
                  'fish',
                  'html',
                  'java',
                  'javascript',
                  'json',
                  'json5',
                  'lua',
                  'pug',
                  'python',
                  'ruby',
                  'rust',
                  'scss',
                  'toml',
                  'tsx',
                  'typescript',
                  'vimdoc',
                  'vim',
                  'yaml',
                },
            })
        end
    },
    -- Terminal plugin
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function ()
            require("config.toggleterm-lazygit")
            require("toggleterm").setup()
        end
    },
    -- Status bar
	{
        "freddiehaddad/feline.nvim",
        config = function ()
            require("feline").setup({
                theme = gruvbox
            })
        end
    },
    -- Top buffer lines
    {
        'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
        config = function ()
            require("bufferline").setup({
                options = {
                    offsets = {
                        {
                            filetype = "carbon.explorer",
                            text = function()
                                return vim.fn.getcwd()
                            end,
                            highlight = "Directory",
                            separator = true -- use a "true" to enable the default, or set your own character
                        }
                    }
                }
            })
        end
    },
    { "ojroques/nvim-bufdel" },
    -- Markdown
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    },
    -- Wakatime
    { 'wakatime/vim-wakatime', lazy = false },
})
