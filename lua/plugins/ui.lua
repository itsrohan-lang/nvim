-- Disable built-in netrw so it doesn't show up when opening a directory
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Configure Tokyonight Colorscheme
require("tokyonight").setup({
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
})
vim.cmd([[colorscheme tokyonight-storm]])

-- Configure Smooth Animated Cursor (smear-cursor.nvim)
-- This completely solves Kitty cursor trail limitations in Neovim!
require("smear_cursor").setup({
  stiffness = 0.8,              -- 0.1 (loose) to 1.0 (stiff)
  trailing_stiffness = 0.5,
  distance_stop_animating = 0.5,
  hide_target_hack = false,
})

-- Configure Beautiful UI Prompts (dressing.nvim)
require("dressing").setup({
  input = {
    enabled = true,
    default_prompt = "➤ ",
    border = "rounded",
    relative = "editor",
    prefer_width = 40,
  },
  select = {
    enabled = true,
    backend = { "telescope", "builtin" },
  },
})

-- Configure Indent Guides (indent-blankline.nvim)
require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = true, show_start = false, show_end = false },
})

-- Configure LSP Progress Spinner (fidget.nvim)
require("fidget").setup({})

-- Configure Statusline (lualine.nvim)
require("lualine").setup({
  options = {
    theme = "tokyonight",
    globalstatus = true,
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "dashboard", "alpha", "starter" },
    },
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } },
  },
})



-- Configure Git Gutter Indicators (gitsigns.nvim)
require("gitsigns").setup({
  signs = {
    add          = { text = "▎" },
    change       = { text = "▎" },
    delete       = { text = "" },
    topdelete    = { text = "" },
    changedelete = { text = "░" },
    untracked    = { text = "▎" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Next Git Hunk" })

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Prev Git Hunk" })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
    map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Hunk (Visual)" })
    map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk (Visual)" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk Inline" })
    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Git Blame Line" })
    map("n", "<leader>hd", gs.diffthis, { desc = "Diff Against Index" })
    map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff Against Last Commit" })
    map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Git Deleted Lines" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Git Hunk" })
  end,
})

-- Buffer Navigation Keymaps
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })


