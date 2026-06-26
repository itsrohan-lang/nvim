-- 1. Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Load core options and keymaps
require("config.options")
require("config.keymaps")

-- 3. Load native plugin configurations
require("plugins.ui")
require("plugins.editor")
require("plugins.coding")
require("plugins.treesitter")
require("plugins.lsp")
