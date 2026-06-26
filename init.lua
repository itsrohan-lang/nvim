-- 1. Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Bootstrap the lazy.nvim plugin manager
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

-- 3. Configure basic Neovim options
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.splitright = true -- Vertical splits to the right
vim.opt.splitbelow = true -- Horizontal splits below
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent (2 spaces)
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.softtabstop = 2 -- Number of spaces soft tabs count for
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.termguicolors = true -- True color support
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if search contains capitals

-- Quick window navigation (switch between explorer and editor splits)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- 4. Setup lazy.nvim and load plugins
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

    -- File explorer (neo-tree) styled and configured like LazyVim
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      keys = {
        {
          "<leader>fe",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        {
          "<leader>fE",
          function()
            -- Get directory of current buffer, or cwd if none
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir = current_file ~= "" and vim.fn.fnamemodify(current_file, ":h") or vim.uv.cwd()
            require("neo-tree.command").execute({ toggle = true, dir = current_dir })
          end,
          desc = "Explorer NeoTree (Current File)",
        },
        {
          "<leader>e",
          "<leader>fe",
          desc = "Explorer NeoTree (cwd)",
          remap = true,
        },
        {
          "<leader>E",
          "<leader>fE",
          desc = "Explorer NeoTree (Current File)",
          remap = true,
        },
        {
          "<leader>ge",
          function()
            require("neo-tree.command").execute({ source = "git_status", toggle = true })
          end,
          desc = "Git Explorer",
        },
        {
          "<leader>be",
          function()
            require("neo-tree.command").execute({ source = "buffers", toggle = true })
          end,
          desc = "Buffer Explorer",
        },
      },
      opts = {
        close_if_last_window = true,
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          filtered_items = {
            visible = true, -- show filtered items (faded) on startup
            hide_dotfiles = true, -- classify hidden files/folders as filtered items
            hide_gitignored = true, -- classify git-ignored files/folders as filtered items
          },
        },
        window = {
          mappings = {
            ["<space>"] = "none", -- Disable space to prevent conflict with leader key
            ["/"] = "none", -- Disable filtering, fallback to standard Vim search
            ["n"] = { "add", config = { show_path = "none" } }, -- Create new file/directory (end with / for directory)
            ["N"] = "add_directory", -- Explicitly create new directory
          },
        },
      },
    },

    -- Fuzzy finder for searching files, text, and buffers (Telescope)
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" },
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Workspace)" },
        { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Workspace)" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text (Grep)" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
      },
      opts = {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      },
    },

    -- Auto-pairs for bracket auto-completion
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = {},
    },

    -- Treesitter for syntax highlighting of most languages
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      main = "nvim-treesitter",
      opts = {
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "html",
          "css",
          "python",
          "go",
          "rust",
          "json",
          "yaml",
          "markdown",
          "bash",
        },
        highlight = { enable = true },
        indent = { enable = true },
      },
    },

    -- Auto-completion engine
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
          experimental = {
            ghost_text = true, -- Shows grey inline "ghost text" for the top suggestion
          },
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
          }, {
            { name = "buffer" },
          }),
        })
      end,
    },

    -- Codeium (Free AI Coding Assistant / Copilot Alternative)
    {
      "Exafunction/codeium.vim",
      event = "BufReadPost",
      config = function()
        -- Disable standard Tab keymap to avoid conflicts with nvim-cmp
        vim.g.codeium_no_map_tab = 1
        -- Map C-g (Ctrl + g) to accept the AI suggestion
        vim.keymap.set("i", "<C-g>", function()
          return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true })
        -- Map Alt + ] and Alt + [ to cycle through AI suggestions
        vim.keymap.set("i", "<M-]>", function()
          return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true, silent = true })
        -- Map Alt + [ to cycle backward
        vim.keymap.set("i", "<M-[>", function()
          return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true, silent = true })
        -- Map Ctrl + x to clear the current AI suggestion
        vim.keymap.set("i", "<C-x>", function()
          return vim.fn["codeium#Clear"]()
        end, { expr = true, silent = true })
      end,
    },

    -- LSP Configuration (Language Servers)
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "lua_ls",
            "ts_ls",
            "html",
            "cssls",
            "pyright",
            "jsonls",
            "yamlls",
          },
        })

        -- Set up keymaps when an LSP attaches to a buffer (native Neovim 0.8+ way)
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local bufnr = args.buf
            local opts = { buffer = bufnr }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          end,
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local servers = {
          "lua_ls",
          "ts_ls",
          "html",
          "cssls",
          "pyright",
          "jsonls",
          "yamlls",
        }

        -- Configure and enable each server using native Neovim 0.11 APIs
        for _, server in ipairs(servers) do
          vim.lsp.config(server, {
            capabilities = capabilities,
          })
          vim.lsp.enable(server)
        end
      end,
    },
  },
})
