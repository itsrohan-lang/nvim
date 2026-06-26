vim.g.mapleader = " "
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
          		{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
          		{ out, "WarningMsg" },
        		{ "\nPress any key to exit..." },
        	}, true, {})
        	vim.fn.getchar()
        	os.exit(1)
	end
    end
    vim.opt.rtp:prepend(lazypath)
vim.opt.number = true          -- Show line numbers
    vim.opt.relativenumber = true  -- Relative line numbers
    vim.opt.splitright = true      -- Vertical splits to the right
    vim.opt.splitbelow = true      -- Horizontal splits below
    vim.opt.expandtab = true       -- Use spaces instead of tabs
    vim.opt.shiftwidth = 4         -- Size of an indent
    vim.opt.tabstop = 4            -- Number of spaces tabs count for
    vim.opt.smartindent = true     -- Insert indents automatically
    vim.opt.termguicolors = true   -- True color support
    vim.opt.ignorecase = true      -- Ignore case in search patterns
    vim.opt.smartcase = true       -- Override ignorecase if search contains capitals


require("lazy").setup({
      spec = {
        -- Add a colorscheme (e.g., Tokyonight)
        {
          "folke/tokyonight.nvim",
          lazy = false,
          priority = 1000,
          opts = {
            transparent = true,
            styles = {
              sidebars = "transparent",
              floats = "transparent",
            },
          },
          config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd([[colorscheme tokyonight-storm]])
          end,
        },

        -- Add a file explorer (e.g., neo-tree)
        {
          "nvim-neo-tree/neo-tree.nvim",
          branch = "v3.x",
          dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
          },
          keys = {
            { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
          },
        },
      },
    })
