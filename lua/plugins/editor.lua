-- Configure Autopairs
require("nvim-autopairs").setup({})

-- Configure Telescope Fuzzy Finder
-- Set global keymaps for Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Workspace)" })
vim.keymap.set("n", "<leader><space>", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Workspace)" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find Text (Grep)" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
vim.keymap.set("n", "<leader>?", "<cmd>Telescope keymaps<cr>", { desc = "Search Keymaps" })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Search Keymaps" })

-- Configure Oil.nvim (Buffer-based File Explorer)
require("oil").setup({
  default_file_explorer = true,
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Parent Directory (Oil)" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open File Explorer (Oil)" })

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ❯ ",
    entry_prefix = "   ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    path_display = { "truncate" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob",
      "!**/.git/*",
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<Esc>"] = actions.close,
      },
      n = {
        ["<Esc>"] = actions.close,
        ["q"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
})

-- Automatically open Telescope when opening a directory (e.g. `nvim .`)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.cmd("cd " .. vim.fn.fnameescape(arg))
      vim.cmd("bwipeout!") -- Delete the empty directory buffer
      require("telescope.builtin").find_files()
    end
  end,
})


-- Configure Keymap Helper (which-key.nvim)
local wk = require("which-key")
wk.setup({
  preset = "classic",
})

-- Register keymap prefix groups
wk.add({
  { "<leader>b", group = "buffer" },
  { "<leader>c", group = "code/lsp" },
  { "<leader>f", group = "find/file" },
  { "<leader>g", group = "git explorer" },
  { "<leader>h", group = "git hunk" },
  { "<leader>q", group = "quit/session" },
  { "<leader>s", group = "search" },
  { "<leader>t", group = "toggle" },
  { "<leader>x", group = "diagnostics/trouble" },
})

-- Configure Diagnostics Panel (trouble.nvim)
require("trouble").setup({})

-- Trouble Keymaps
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Configure Session Persistence (persistence.nvim)
require("persistence").setup({})

-- Session Keymaps
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session (cwd)" })
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Session on Exit" })

-- Configure Harpoon (harpoon2)
local harpoon = require("harpoon")
harpoon:setup()

-- Harpoon Keymaps
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon File" })
vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon File 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon File 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon File 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon File 4" })

-- Configure Terminal (toggleterm.nvim)
require("toggleterm").setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

-- Terminal Keymaps for easier escaping and navigation
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    set_terminal_keymaps()
  end,
})
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })

-- Configure Lazygit using toggleterm
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("checktime")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Lazygit" })

-- Configure Fast Navigation (flash.nvim)
require("flash").setup({
  modes = {
    search = {
      enabled = true,
    },
  },
})

vim.keymap.set({"n", "x", "o"}, "s", function() require("flash").jump() end, { desc = "Flash Jump" })
vim.keymap.set({"n", "x", "o"}, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Configure nvim-surround (Helix-style mappings) v4 migration
vim.g.nvim_surround_no_mappings = true
require("nvim-surround").setup({})

vim.keymap.set("i", "<C-g>s", "<Plug>(nvim-surround-insert)", { desc = "Add surround (insert)" })
vim.keymap.set("i", "<C-g>S", "<Plug>(nvim-surround-insert-line)", { desc = "Add surround line (insert)" })
vim.keymap.set("n", "ms", "<Plug>(nvim-surround-normal)", { desc = "Add surround (Helix)" })
vim.keymap.set("n", "mss", "<Plug>(nvim-surround-normal-cur)", { desc = "Add surround current line" })
vim.keymap.set("n", "mS", "<Plug>(nvim-surround-normal-line)", { desc = "Add surround line" })
vim.keymap.set("n", "mSS", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Add surround cur line" })
vim.keymap.set("x", "ms", "<Plug>(nvim-surround-visual)", { desc = "Add surround (visual)" })
vim.keymap.set("x", "mS", "<Plug>(nvim-surround-visual-line)", { desc = "Add surround line (visual)" })
vim.keymap.set("n", "md", "<Plug>(nvim-surround-delete)", { desc = "Delete surround (Helix)" })
vim.keymap.set("n", "mr", "<Plug>(nvim-surround-change)", { desc = "Change surround (Helix)" })

-- Configure Obsidian.nvim
require("obsidian").setup({
  workspaces = {
    {
      name = "personal",
      path = "~/Documents/Obsidian", -- Default path, can be changed later
    },
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  mappings = {
    ["gf"] = {
      action = function() return require("obsidian").util.gf_passthrough() end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    ["<leader>ch"] = {
      action = function() return require("obsidian").util.toggle_checkbox() end,
      opts = { buffer = true, desc = "Toggle Obsidian Checkbox" },
    },
  },
})
