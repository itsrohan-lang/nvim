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
