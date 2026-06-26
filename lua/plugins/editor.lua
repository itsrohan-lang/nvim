return {
  -- Auto-pairs for bracket auto-completion
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Fuzzy finder for searching files, text, and buffers (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Workspace)" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Workspace)" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text (Grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
  },

  -- Codeium (Free AI Coding Assistant / Copilot Alternative)
  {
    "Exafunction/codeium.vim",
    event = "BufReadPost",
    config = function()
      -- Disable standard Tab keymap to avoid conflicts with nvim-cmp
      vim.g.codeium_no_map_tab = 1
      -- Map C-g (Ctrl + g) to accept the AI suggestion
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      -- Map Alt + ] and Alt + [ to cycle through AI suggestions
      vim.keymap.set("i", "<M-]>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      -- Map Alt + [ to cycle backward
      vim.keymap.set("i", "<M-[>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      -- Map Ctrl + x to clear the current AI suggestion
      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },
}
