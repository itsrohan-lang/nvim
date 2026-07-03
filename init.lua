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
  { name = "toggleterm.nvim", repo = "https://github.com/akinsho/toggleterm.nvim.git" },
  { name = "vim-dadbod", repo = "https://github.com/tpope/vim-dadbod.git" },
  { name = "vim-dadbod-ui", repo = "https://github.com/kristijanhusak/vim-dadbod-ui.git" },
  { name = "vim-dadbod-completion", repo = "https://github.com/kristijanhusak/vim-dadbod-completion.git" },
  { name = "nvim-treesitter", repo = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
  { name = "nvim-cmp", repo = "https://github.com/hrsh7th/nvim-cmp.git" },
  { name = "cmp-nvim-lsp", repo = "https://github.com/hrsh7th/cmp-nvim-lsp.git" },
  { name = "cmp-buffer", repo = "https://github.com/hrsh7th/cmp-buffer.git" },
  { name = "cmp-path", repo = "https://github.com/hrsh7th/cmp-path.git" },
  { name = "LuaSnip", repo = "https://github.com/L3MON4D3/LuaSnip.git" },
  { name = "cmp_luasnip", repo = "https://github.com/saadparwaiz1/cmp_luasnip.git" },
  { name = "nvim-lspconfig", repo = "https://github.com/neovim/nvim-lspconfig.git" },
  { name = "lualine.nvim", repo = "https://github.com/nvim-lualine/lualine.nvim.git" },
  { name = "bufferline.nvim", repo = "https://github.com/akinsho/bufferline.nvim.git" },
  { name = "gitsigns.nvim", repo = "https://github.com/lewis6991/gitsigns.nvim.git" },
  { name = "which-key.nvim", repo = "https://github.com/folke/which-key.nvim.git" },
  { name = "conform.nvim", repo = "https://github.com/stevearc/conform.nvim.git" },
  { name = "trouble.nvim", repo = "https://github.com/folke/trouble.nvim.git" },
  { name = "dressing.nvim", repo = "https://github.com/stevearc/dressing.nvim.git" },
  { name = "image.nvim", repo = "https://github.com/3rd/image.nvim.git" },
  { name = "alpha-nvim", repo = "https://github.com/goolord/alpha-nvim.git" },
  { name = "persistence.nvim", repo = "https://github.com/folke/persistence.nvim.git" },
  { name = "harpoon", repo = "https://github.com/ThePrimeagen/harpoon.git", branch = "harpoon2" },
  { name = "vim-visual-multi", repo = "https://github.com/mg979/vim-visual-multi.git" },
  { name = "nvim-surround", repo = "https://github.com/kylechui/nvim-surround.git" },
  { name = "nvim-treesitter-textobjects", repo = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git" },
  { name = "obsidian.nvim", repo = "https://github.com/epwalsh/obsidian.nvim.git" },
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
    local cmd = { "git", "clone", "--depth=1" }
    if plugin.branch then
      table.insert(cmd, "-b")
      table.insert(cmd, plugin.branch)
    end
    table.insert(cmd, plugin.repo)
    table.insert(cmd, plugin_path)
    local out = vim.fn.system(cmd)
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

-- 5. Asynchronous Plugin Updater (:PluginUpdate)
-- Updates all installed native plugins in parallel without blocking the editor
vim.api.nvim_create_user_command("PluginUpdate", function()
  local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start"
  local uv = vim.uv or vim.loop
  local plugins_to_update = {}

  local handle = uv.fs_scandir(pack_path)
  if not handle then
    vim.api.nvim_echo({ { "Failed to read plugin directory.", "ErrorMsg" } }, true, {})
    return
  end

  while true do
    local name, type = uv.fs_scandir_next(handle)
    if not name then break end
    if type == "directory" and name ~= "." and name ~= ".." then
      table.insert(plugins_to_update, name)
    end
  end

  if #plugins_to_update == 0 then
    vim.api.nvim_echo({ { "No plugins found to update.", "WarningMsg" } }, true, {})
    return
  end

  vim.api.nvim_echo({ { "Checking for updates in the background...", "WarningMsg" } }, true, {})

  local completed = 0
  local updated = {}
  local failed = {}

  for _, name in ipairs(plugins_to_update) do
    local path = pack_path .. "/" .. name
    vim.fn.jobstart({ "git", "-C", path, "pull", "--rebase", "--depth=1" }, {
      on_exit = function(_, exit_code)
        completed = completed + 1
        if exit_code == 0 then
          table.insert(updated, name)
        else
          table.insert(failed, name)
        end

        -- Print summary once all jobs finish
        if completed == #plugins_to_update then
          local msg = { { "Plugin Update Complete!\n", "WarningMsg" } }
          if #updated > 0 then
            table.insert(msg, { "Successfully updated: " .. table.concat(updated, ", ") .. "\n", "Normal" })
          end
          if #failed > 0 then
            table.insert(msg, { "Failed to update: " .. table.concat(failed, ", ") .. "\n", "ErrorMsg" })
          end
          vim.schedule(function()
            vim.api.nvim_echo(msg, true, {})
          end)
        end
      end
    })
  end
end, {})

-- Automatic background update check (triggers once every 7 days)
local cache_dir = vim.fn.stdpath("cache")
local timestamp_file = cache_dir .. "/last_plugin_update"
local current_time = os.time()
local seven_days = 7 * 24 * 60 * 60

local last_update = 0
local f = io.open(timestamp_file, "r")
if f then
  local content = f:read("*all")
  f:close()
  last_update = tonumber(content) or 0
end

if current_time - last_update > seven_days then
  vim.defer_fn(function()
    vim.cmd("PluginUpdate")
    -- Save new timestamp
    local f_write = io.open(timestamp_file, "w")
    if f_write then
      f_write:write(tostring(current_time))
      f_write:close()
    end
  end, 1000) -- Delays execution by 1 second to keep initial startup instantaneous
end
