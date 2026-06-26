-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.mjs", "*.cjs", "*.md", "*.yaml" },
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.fixAll.oxc" }, diagnostics = {} },
      apply = true,
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.html",
  callback = function(args)
    local first_lines = vim.api.nvim_buf_get_lines(args.buf, 0, 20, false)
    for _, line in ipairs(first_lines) do
      if line:match("{%%") or line:match("{{") or line:match("^%-%-%-") then
        vim.bo[args.buf].filetype = "liquid"
        return
      end
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("hi! Normal guibg=NONE ctermbg=NONE")
    vim.cmd("hi! NonText guibg=NONE ctermbg=NONE")
  end,
})
