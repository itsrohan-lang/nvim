-- Configure Tokyonight Colorscheme
require("tokyonight").setup({
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
})
vim.cmd([[colorscheme tokyonight-storm]])

-- Configure File Explorer (Neo-tree)
-- Set global keymaps for Neo-tree (since we are not using lazy.nvim's keys property)
vim.keymap.set("n", "<leader>fe", function()
  require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end, { desc = "Explorer NeoTree (cwd)" })

vim.keymap.set("n", "<leader>fE", function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = current_file ~= "" and vim.fn.fnamemodify(current_file, ":h") or vim.uv.cwd()
  require("neo-tree.command").execute({ toggle = true, dir = current_dir })
end, { desc = "Explorer NeoTree (Current File)" })

vim.keymap.set("n", "<leader>e", "<leader>fe", { desc = "Explorer NeoTree (cwd)", remap = true })
vim.keymap.set("n", "<leader>E", "<leader>fE", { desc = "Explorer NeoTree (Current File)", remap = true })

vim.keymap.set("n", "<leader>ge", function()
  require("neo-tree.command").execute({ source = "git_status", toggle = true })
end, { desc = "Git Explorer" })

vim.keymap.set("n", "<leader>be", function()
  require("neo-tree.command").execute({ source = "buffers", toggle = true })
end, { desc = "Buffer Explorer" })

require("neo-tree").setup({
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
})

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

-- Configure Tabline/Bufferline (bufferline.nvim)
require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
    show_buffer_close_icons = true,
    show_close_icon = true,
  },
})

-- Buffer Navigation Keymaps
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

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
