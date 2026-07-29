-- Disable built-in netrw so it doesn't show up when opening a directory
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Configure Catppuccin Colorscheme (Matches Ghostty Mocha & Maple Mono typography)
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  transparent_background = true, -- Inherits Ghostty's black background and glass blur
  term_colors = true,
  styles = {
    comments = { "italic" },     -- Uses Maple Mono cursive italic
    keywords = { "italic" },     -- Uses Maple Mono cursive italic
    functions = { "italic" },    -- Uses Maple Mono cursive italic
    conditionals = { "italic" }, -- Uses Maple Mono cursive italic
    loops = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = false,
    treesitter = true,
    mason = true,
    telescope = {
      enabled = true,
      style = "nvchad",
    },
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin")

-- Configure Smooth Animated Cursor (smear-cursor.nvim)
-- This completely solves Kitty cursor trail limitations in Neovim!
require("smear_cursor").setup({
  stiffness = 0.8,              -- 0.1 (loose) to 1.0 (stiff)
  trailing_stiffness = 0.5,
  distance_stop_animating = 0.5,
  hide_target_hack = false,
})

-- Configure Smooth Scrolling (neoscroll.nvim)
require("neoscroll").setup({
  mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = "quadratic", -- "linear", "quadratic", "cubic", "quartic", "quintic", "circular", "sine"
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

-- Configure Statusline (GitHub Trending: "Evil Lualine" - Transparent, Dynamic & Minimal)
local mocha = require("catppuccin.palettes").get_palette("mocha")

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
}

local evil_config = {
  options = {
    component_separators = "",
    section_separators = "",
    theme = {
      normal = { c = { fg = mocha.text, bg = "NONE" } },
      inactive = { c = { fg = mocha.subtext0, bg = "NONE" } },
    },
    globalstatus = true,
    disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(evil_config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(evil_config.sections.lualine_x, component)
end

-- 1. Dynamic Mode Pill Indicator
ins_left({
  function()
    return "▊"
  end,
  color = function()
    local mode_color = {
      n = mocha.blue,
      i = mocha.green,
      v = mocha.mauve,
      [" "] = mocha.mauve,
      V = mocha.mauve,
      c = mocha.yellow,
      no = mocha.red,
      s = mocha.orange,
      S = mocha.orange,
      [" "] = mocha.orange,
      ic = mocha.yellow,
      R = mocha.red,
      Rv = mocha.red,
      cv = mocha.red,
      ce = mocha.red,
      r = mocha.teal,
      rm = mocha.teal,
      ["r?"] = mocha.teal,
      ["!"] = mocha.red,
      t = mocha.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { left = 0, right = 1 },
})

-- 2. Mode Name Text
ins_left({
  function()
    return vim.fn.mode():upper()
  end,
  color = function()
    local mode_color = {
      n = mocha.blue,
      i = mocha.green,
      v = mocha.mauve,
      [" "] = mocha.mauve,
      V = mocha.mauve,
      c = mocha.yellow,
      no = mocha.red,
      s = mocha.orange,
      S = mocha.orange,
      [" "] = mocha.orange,
      ic = mocha.yellow,
      R = mocha.red,
      Rv = mocha.red,
      cv = mocha.red,
      ce = mocha.red,
      r = mocha.teal,
      rm = mocha.teal,
      ["r?"] = mocha.teal,
      ["!"] = mocha.red,
      t = mocha.red,
    }
    return { fg = mode_color[vim.fn.mode()], gui = "bold" }
  end,
  padding = { right = 1 },
})

-- 3. File Size
ins_left({
  "filesize",
  cond = conditions.buffer_not_empty,
  color = { fg = mocha.subtext0 },
})

-- 4. File Name
ins_left({
  "filename",
  cond = conditions.buffer_not_empty,
  color = { fg = mocha.peach, gui = "bold" },
  symbols = { modified = " ●", readonly = " 🔒", unnamed = "[No Name]" },
})

-- 5. Location & Progress
ins_left({ "location", color = { fg = mocha.subtext1 } })
ins_left({ "progress", color = { fg = mocha.subtext0 } })

-- 6. Diagnostics
ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
  diagnostics_color = {
    error = { fg = mocha.red },
    warn = { fg = mocha.yellow },
    info = { fg = mocha.sky },
    hint = { fg = mocha.teal },
  },
})

-- Spacer (Pushes following items to the right)
ins_left({
  function()
    return "%="
  end,
})

-- 7. Active LSP Indicator
ins_left({
  function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then
      return "󰅛 No LSP"
    end
    local names = {}
    for _, client in ipairs(clients) do
      table.insert(names, client.name)
    end
    return "  " .. table.concat(names, ", ")
  end,
  color = { fg = mocha.teal, gui = "bold" },
})

-- 8. Filetype
ins_right({
  "filetype",
  icon_only = false,
  color = { fg = mocha.subtext0 },
})

-- 9. Git Branch
ins_right({
  "branch",
  icon = "",
  color = { fg = mocha.lavender, gui = "bold" },
})

-- 10. Git Diff
ins_right({
  "diff",
  symbols = { added = " ", modified = "󰝤 ", removed = " " },
  diff_color = {
    added = { fg = mocha.green },
    modified = { fg = mocha.orange },
    removed = { fg = mocha.red },
  },
  cond = conditions.hide_in_width,
})

-- 11. Right Dynamic Mode Bar
ins_right({
  function()
    return "▊"
  end,
  color = function()
    local mode_color = {
      n = mocha.blue,
      i = mocha.green,
      v = mocha.mauve,
      [" "] = mocha.mauve,
      V = mocha.mauve,
      c = mocha.yellow,
      no = mocha.red,
      s = mocha.orange,
      S = mocha.orange,
      [" "] = mocha.orange,
      ic = mocha.yellow,
      R = mocha.red,
      Rv = mocha.red,
      cv = mocha.red,
      ce = mocha.red,
      r = mocha.teal,
      rm = mocha.teal,
      ["r?"] = mocha.teal,
      ["!"] = mocha.red,
      t = mocha.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { left = 1 },
})

require("lualine").setup(evil_config)



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

-- Configure Tabline/Bufferline (bufferline.nvim)
require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
  },
})

-- Buffer Navigation Keymaps
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })


