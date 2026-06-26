-- Configure Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "query", -- Parser for Tree-sitter query files (.scm)
    "regex", -- Parser for regular expressions
    "javascript", -- JS and standard JSX
    "typescript",
    "tsx", -- TypeScript JSX
    "html",
    "css",
    "python",
    "go",
    "rust",
    "json",
    "yaml",
    "markdown",
    "bash",
    "c",
    "cpp", -- C++
    "zig",
    "php",
    "php_only",
    "nix",
  },
  highlight = { enable = true },
  indent = { enable = true },
})
