-- Quick window navigation (switch between explorer and editor splits)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Center cursor on vertical scroll jumps (reduces eye strain)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down & Center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up & Center" })

-- Center cursor on search matches (prevents cursor from getting lost)
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Match & Center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Search Match & Center" })

-- Move selected lines up/down in visual mode (VS Code-like line dragging)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Drag Selection Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Drag Selection Up" })

-- Yank to system clipboard easily (Space + y in normal/visual mode)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to System Clipboard" })

-- Toggle back and forth between your last two active files (Space + Backspace)
vim.keymap.set("n", "<leader><BS>", "<cmd>e #<cr>", { desc = "Toggle Last Active File" })

-- Show keybind reminder on startup (deferred to ensure it prints after UI draws)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_echo({
        { "Welcome! Press ", "Normal" },
        { "<Space> + ?", "WarningMsg" },
        { " to view all keybinds.", "Normal" }
      }, false, {})
    end, 50)
  end,
})
