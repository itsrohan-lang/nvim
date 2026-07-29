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

-- Configure Statusline (lualine.nvim - Ultra-Colorful Glass Pills)
local mocha = require("catppuccin.palettes").get_palette("mocha")

local custom_catppuccin_theme = {
  normal = {
    a = { bg = mocha.blue, fg = mocha.crust, gui = "bold" },
    b = { bg = mocha.surface0, fg = mocha.mauve, gui = "bold" },
    c = { bg = "NONE", fg = mocha.text },
  },
  insert = {
    a = { bg = mocha.green, fg = mocha.crust, gui = "bold" },
  },
  visual = {
    a = { bg = mocha.mauve, fg = mocha.crust, gui = "bold" },
  },
  replace = {
    a = { bg = mocha.red, fg = mocha.crust, gui = "bold" },
  },
  command = {
    a = { bg = mocha.yellow, fg = mocha.crust, gui = "bold" },
  },
  inactive = {
    a = { bg = mocha.surface0, fg = mocha.subtext0 },
    b = { bg = mocha.surface0, fg = mocha.subtext0 },
    c = { bg = "NONE", fg = mocha.subtext0 },
  },
}

require("lualine").setup({
  options = {
    theme = custom_catppuccin_theme,
    globalstatus = true,
    component_separators = "",
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "dashboard", "alpha", "starter" },
    },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        icon = "",
        separator = { left = "", right = "" },
      },
    },
    lualine_b = {
      {
        "branch",
        icon = "",
        color = { bg = mocha.surface0, fg = mocha.pink, gui = "bold" },
        separator = { left = "", right = "" },
      },
      {
        "diff",
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 1,
        symbols = { modified = " 󰏫", readonly = " 󰌾", unnamed = " [No Name]" },
        color = { fg = mocha.peach, gui = "bold" },
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
      },
    },
    lualine_x = {
      {
        function()
          local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
          if #buf_clients == 0 then
            return "󰅛 No LSP"
          end
          local names = {}
          for _, client in ipairs(buf_clients) do
            table.insert(names, client.name)
          end
          return "  " .. table.concat(names, ", ")
        end,
        color = { bg = mocha.surface0, fg = mocha.teal, gui = "bold" },
        separator = { left = "", right = "" },
      },
      {
        "filetype",
        icon_only = false,
        color = { bg = mocha.surface0, fg = mocha.sapphire, gui = "bold" },
        separator = { left = "", right = "" },
      },
      {
        "encoding",
        color = { fg = mocha.subtext0, gui = "bold" },
      },
    },
    lualine_y = {
      {
        "progress",
        color = { bg = mocha.surface0, fg = mocha.green, gui = "bold" },
        separator = { left = "", right = "" },
      },
    },
    lualine_z = {
      {
        "location",
        icon = "",
        color = { bg = mocha.lavender, fg = mocha.crust, gui = "bold" },
        separator = { left = "", right = "" },
      },
    },
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


