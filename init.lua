-- 1. Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Load core options and keymaps
require("config.options")
require("config.keymaps")

-- 3. Automatic Bootstrap of Native Plugins (for new systems)
local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start"
local plugins = {
  { name = "tokyonight.nvim", repo = "https://github.com/folke/tokyonight.nvim.git" },
  { name = "neo-tree.nvim", repo = "https://github.com/nvim-neo-tree/neo-tree.nvim.git" },
  { name = "plenary.nvim", repo = "https://github.com/nvim-lua/plenary.nvim.git" },
  { name = "nvim-web-devicons", repo = "https://github.com/nvim-tree/nvim-web-devicons" },
  { name = "nui.nvim", repo = "https://github.com/MunifTanjim/nui.nvim.git" },
  { name = "nvim-autopairs", repo = "https://github.com/windwp/nvim-autopairs.git" },
  { name = "telescope.nvim", repo = "https://github.com/nvim-telescope/telescope.nvim.git" },
  { name = "nvim-treesitter", repo = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
  { name = "nvim-cmp", repo = "https://github.com/hrsh7th/nvim-cmp.git" },
  { name = "cmp-nvim-lsp", repo = "https://github.com/hrsh7th/cmp-nvim-lsp.git" },
  { name = "cmp-buffer", repo = "https://github.com/hrsh7th/cmp-buffer.git" },
  { name = "cmp-path", repo = "https://github.com/hrsh7th/cmp-path.git" },
  { name = "LuaSnip", repo = "https://github.com/L3MON4D3/LuaSnip.git" },
  { name = "cmp_luasnip", repo = "https://github.com/saadparwaiz1/cmp_luasnip.git" },
  { name = "nvim-lspconfig", repo = "https://github.com/neovim/nvim-lspconfig.git" },
  { name = "mason.nvim", repo = "https://github.com/williamboman/mason.nvim.git" },
  { name = "mason-lspconfig.nvim", repo = "https://github.com/williamboman/mason-lspconfig.nvim.git" },
  { name = "lualine.nvim", repo = "https://github.com/nvim-lualine/lualine.nvim.git" },
  { name = "bufferline.nvim", repo = "https://github.com/akinsho/bufferline.nvim.git" },
  { name = "gitsigns.nvim", repo = "https://github.com/lewis6991/gitsigns.nvim.git" },
  { name = "which-key.nvim", repo = "https://github.com/folke/which-key.nvim.git" },
  { name = "conform.nvim", repo = "https://github.com/stevearc/conform.nvim.git" },
  { name = "trouble.nvim", repo = "https://github.com/folke/trouble.nvim.git" },
  { name = "dressing.nvim", repo = "https://github.com/stevearc/dressing.nvim.git" },
  { name = "image.nvim", repo = "https://github.com/3rd/image.nvim.git" },
}

local missing_plugins = {}
for _, plugin in ipairs(plugins) do
  local plugin_path = pack_path .. "/" .. plugin.name
  if vim.fn.empty(vim.fn.glob(plugin_path)) > 0 then
    table.insert(missing_plugins, plugin)
  end
end

if #missing_plugins > 0 then
  vim.api.nvim_echo({ { "Missing native plugins detected. Installing...", "WarningMsg" } }, true, {})
  vim.fn.mkdir(pack_path, "p")
  for _, plugin in ipairs(missing_plugins) do
    local plugin_path = pack_path .. "/" .. plugin.name
    vim.api.nvim_echo({ { "Cloning " .. plugin.name .. "...", "Normal" } }, true, {})
    local out = vim.fn.system({ "git", "clone", "--depth=1", plugin.repo, plugin_path })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({ { "Failed to clone " .. plugin.name .. ":\n" .. out, "ErrorMsg" } }, true, {})
    end
  end
  vim.api.nvim_echo({ { "All plugins installed successfully! Please restart Neovim.", "WarningMsg" } }, true, {})
  -- Force Neovim to load the newly cloned packages immediately
  vim.cmd("packloadall")
end

-- 4. Load native plugin configurations
require("plugins.ui")
require("plugins.editor")
require("plugins.coding")
require("plugins.treesitter")
require("plugins.lsp")
