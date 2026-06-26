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
