return {
  -- Treesitter for syntax highlighting of most languages
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query", -- Parser for Tree-sitter query files (.scm)
        "regex", -- Parser for regular expressions
        "javascript",
        "typescript",
        "html",
        "css",
        "python",
        "go",
        "rust",
        "json",
        "yaml",
        "markdown",
        "bash",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
