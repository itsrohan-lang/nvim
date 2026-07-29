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

-- Mapping of server names to their CLI command names
local server_executables = {
  lua_ls = "lua-language-server",
  ts_ls = "typescript-language-server",
  html = "vscode-html-language-server",
  cssls = "vscode-css-language-server",
  pyright = "pyright-langserver",
  jsonls = "vscode-json-language-server",
  yamlls = "yaml-language-server",
  clangd = "clangd",
  gopls = "gopls",
  rust_analyzer = "rust-analyzer",
  zls = "zls",
  intelephense = "intelephense",
}

-- Detect NixOS
local is_nixos = false
local f = io.open("/etc/os-release", "r")
if f then
  local content = f:read("*a")
  if content:match("ID=nixos") or content:match("ID=\"nixos\"") then
    is_nixos = true
  end
  f:close()
end

-- Only run Mason if we are NOT on NixOS (Pure Nix installs LSPs globally)
if not is_nixos then
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

  -- Configure Mason Tool Installer (automatically installs formatters/linters)
  -- Left empty for minimalism. Use :MasonInstall <tool> when you need it!
  require("mason-tool-installer").setup({
    ensure_installed = {},
  })

  -- Configure Mason-LSPConfig
  require("mason-lspconfig").setup({
    ensure_installed = {},
    automatic_installation = false, -- Disable auto-install to save gigabytes of disk space
  })
end

-- Configure and enable each server using native Neovim 0.11 APIs
-- Only enable servers whose CLI command is actually installed to prevent spawn errors
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
  local exec = server_executables[server]
  if not exec or vim.fn.executable(exec) == 1 then
    vim.lsp.enable(server)
  end
end
