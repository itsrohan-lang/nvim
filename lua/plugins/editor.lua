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

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
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



