-- Set up keymaps when an LSP attaches to a buffer (native Neovim 0.8+ way)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  "lua_ls",
  "ts_ls",
  "html",
  "cssls",
  "pyright",
  "jsonls",
  "yamlls",
  "clangd",
  "gopls",
  "rust_analyzer",
  "zls",
  "intelephense",
}

-- Configure Mason
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Configure Mason-LSPConfig
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Configure and enable each server using native Neovim 0.11 APIs
require("mason-lspconfig").setup_handlers({
  function(server_name)
    vim.lsp.config(server_name, {
      capabilities = capabilities,
    })
    vim.lsp.enable(server_name)
  end,
})
