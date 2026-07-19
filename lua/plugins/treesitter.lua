-- Configure Treesitter
require("nvim-treesitter").setup({
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "query", -- Parser for Tree-sitter query files (.scm)
    "regex", -- Parser for regular expressions
    "markdown",
    "markdown_inline",
  },
  auto_install = true, -- Automatically install missing parsers when entering buffer
  highlight = { enable = true },
  indent = { enable = true },
  
  -- Helix-style incremental selection (like Alt-o / Alt-i in Helix)
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<A-o>",
      node_incremental = "<A-o>",
      scope_incremental = false,
      node_decremental = "<A-i>",
    },
  },
  
  -- Helix-like textobjects
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["maf"] = "@function.outer",
        ["mif"] = "@function.inner",
        ["mac"] = "@class.outer",
        ["mic"] = "@class.inner",
        ["maa"] = "@parameter.outer",
        ["mia"] = "@parameter.inner",
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
    },
  },
})
