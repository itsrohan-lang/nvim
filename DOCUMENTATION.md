# Neovim Configuration Documentation

## 🚀 Getting Started & Installation

This configuration is **100% portable, self-bootstrapping, and cross-platform**. It runs seamlessly on **macOS, Linux, and Windows**. When you open Neovim for the first time, it will automatically clone and configure all 27 native plugins for you.

### 1. Prerequisites (Required Tools)

To ensure Telescope (fuzzy finding), Treesitter (syntax highlighting), and LSP integrations work correctly, you must install the following tools on your system:

#### 🍏 macOS (via Homebrew)
```bash
# Core utilities, search tools, and C compiler (for Treesitter compilation)
brew install neovim git ripgrep fd gcc
```

#### 🐧 Linux (Debian/Ubuntu)
```bash
# Update package list and install tools
sudo apt update
sudo apt install neovim git ripgrep fd-find build-essential gcc make
```
*Note: On Ubuntu, `fd` is installed as `fdfind`. Neovim automatically detects this.*

#### 🐧 Linux (Arch Linux)
```bash
sudo pacman -S neovim git ripgrep fd gcc make
```

####  Windows (via Winget / PowerShell)
```powershell
# Install Neovim, Git, search tools, and MinGW (C compiler for Treesitter)
winget install Neovim.Neovim
winget install Git.Git
winget install BurntSushi.Ripgrep
winget install sharkdp.fd
winget install MSYS2.MSYS2 # Or ensure you have a C compiler like gcc/clang in your PATH
```

#### 🎨 Recommended: Nerd Font
To display beautiful file icons in your statusline, tab bar, and file explorer, you must use a **Nerd Font** in your terminal emulator (e.g., *JetBrainsMono Nerd Font*, *FiraCode Nerd Font*, or *Hack Nerd Font*).
* Download from: [Nerd Fonts Releases](https://www.nerdfonts.com/font-downloads)

---

### 2. How to Clone & Install this Configuration

To set up this configuration for yourself or another user, follow these steps:

#### Step A: Back up your existing configuration (if any)
Before copying this setup, rename or move your current Neovim files to keep a backup.
*   **macOS / Linux:**
    ```bash
    mv ~/.config/nvim ~/.config/nvim.backup
    mv ~/.local/share/nvim ~/.local/share/nvim.backup
    mv ~/.local/state/nvim ~/.local/state/nvim.backup
    mv ~/.cache/nvim ~/.cache/nvim.backup
    ```
*   **Windows (PowerShell):**
    ```powershell
    Rename-Item -Path "$env:LOCALAPPDATA\nvim" -NewName "nvim.backup"
    Rename-Item -Path "$env:LOCALAPPDATA\nvim-data" -NewName "nvim-data.backup"
    ```

#### Step B: Clone the configuration
Clone this repository into Neovim's default configuration path:
*   **macOS / Linux:**
    ```bash
    git clone <your-repository-url> ~/.config/nvim
    ```
*   **Windows (PowerShell):**
    ```powershell
    git clone <your-repository-url> "$env:LOCALAPPDATA\nvim"
    ```

#### Step C: Start Neovim and let it Auto-Bootstrap!
Simply launch Neovim:
```bash
nvim
```
The built-in **native bootstrapper** will automatically detect that plugins are missing, print a message, and download all 27 packages directly from GitHub into your native package directory.
Once complete, **restart Neovim** and everything will be active!

---

### 3. How to Personalize the Configuration for Yourself (Line-by-Line Guide)

This configuration is divided into clean, modular files. Here is an exhaustive, file-by-file, line-by-line guide explaining how any user can customize the editor options, keyboard shortcuts, dashboard, plugins, LSPs, and formatters to suit their personal preferences:

---

#### 🔌 A. The Main Entrypoint: [init.lua](file:///Users/rohan/.config/nvim/init.lua)
This is the root file that Neovim executes first. It sets the leader key, lists plugins, bootstraps them, loads secondary configurations, and manages updates.

*   **Lines 2-3 (`vim.g.mapleader = " "`):** Sets the global `<leader>` key to Space. If you want to change the leader key to a comma, change `" "` to `","`.
*   **Lines 6-7 (`require("config.options")`):** Directs Neovim to load options from `/lua/config/options.lua` and keymaps from `/lua/config/keymaps.lua`.
*   **Lines 11-40 (`local plugins = { ... }`):** The list of all 27 native plugins.
    *   *How to add a plugin:* Add a table entry. E.g., `{ name = "vim-surround", repo = "https://github.com/tpope/vim-surround.git" }`.
    *   *How to pin a branch:* Add the branch key. E.g., `{ name = "harpoon", repo = "...", branch = "harpoon2" }`.
*   **Lines 42-71 (Bootstrapping Logic):** Loops through the `plugins` table, checks if they exist in `~/.local/share/nvim/site/pack/plugins/start/`, and clones them if missing.
    *   *Customization:* If you want to change where plugins are installed, modify `pack_path` on Line 10.
*   **Lines 74-78 (Loading Plugin Configs):** Requires individual plugin setups. If you add a new config file (e.g., `/lua/plugins/custom.lua`), you must add `require("plugins.custom")` here.
*   **Lines 82-139 (`PluginUpdate` command):** Defines the `:PluginUpdate` command, which runs `git pull --rebase --depth=1` asynchronously in parallel for every installed plugin.
*   **Lines 141-165 (Auto-Update Check):** Checks if 7 days have passed since the last update and triggers a background check. You can change the interval by modifying `seven_days` on Line 145 (e.g., change `7` to `1` for daily checks, or `30` for monthly).

---

#### ⚙️ B. Customizing Editor Options: [options.lua](file:///Users/rohan/.config/nvim/lua/config/options.lua)
This file handles standard editor options. Adjust these to change how text, tabs, and windows behave.

*   **Line 2 (`vim.opt.number = true`):** Shows absolute line numbers. Set to `false` to hide them.
*   **Line 3 (`vim.opt.relativenumber = true`):** Enables relative line numbers (helpful for vertical jump motions like `12j` or `8k`). Set to `false` to show absolute numbers only.
*   **Lines 4-5 (`vim.opt.splitright = true` / `vim.opt.splitbelow = true`):** Dictates that vertical splits open to the right and horizontal splits open below. Set to `false` to open them left or above.
*   **Line 6 (`vim.opt.expandtab = true`):** Converts tab presses into spaces. Set to `false` if you prefer hard tabs.
*   **Lines 7-9 (`vim.opt.shiftwidth = 2` / `vim.opt.tabstop = 2` / `vim.opt.softtabstop = 2`):** Sets indentation size. For a 4-space indentation (standard in Python, C, Rust), change all three numbers from `2` to `4`.
*   **Line 10 (`vim.opt.smartindent = true`):** Automatically inserts one extra level of indentation in code blocks (e.g., after opening curly brackets). Set to `false` to disable.
*   **Line 11 (`vim.opt.termguicolors = true`):** Enables 24-bit RGB true colors in the terminal. Must be `true` for modern color themes to display correctly.
*   **Lines 12-13 (`vim.opt.ignorecase = true` / `vim.opt.smartcase = true`):** Makes searches case-insensitive unless your search term contains an uppercase letter. Set both to `false` for strict case-sensitive searching.

---

#### ⌨️ C. Customizing Global Shortcuts: [keymaps.lua](file:///Users/rohan/.config/nvim/lua/config/keymaps.lua)
Add, modify, or remove global keyboard shortcuts.

*   **Lines 2-5 (`vim.keymap.set("n", "<C-h>", "<C-w>h", ...)`):** Maps Ctrl+h/j/k/l to switch window focus between splits. If you prefer standard window commands, delete these lines.
*   **Lines 8-9 (`vim.keymap.set("n", "<C-d>", "<C-d>zz", ...)`):** Locks the cursor to the center of the screen when page-scrolling up/down. Change to `"<C-d>"` to disable centering.
*   **Lines 12-13 (`vim.keymap.set("n", "n", "nzzzv", ...)`):** Keeps the cursor centered when jumping through search matches. Change to `"n"` to disable centering.
*   **Lines 16-17 (`vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", ...)`):** Drags visually selected blocks of code down or up one line with auto-indentation. Change `"J"` or `"K"` to other keys if you want to use them for other actions.
*   **Line 20 (`vim.keymap.set({ "n", "v" }, "<leader>y", [["+y"]], ...)`):** Copies text directly to the system clipboard using Space+y. Change `"<leader>y"` to your preferred copy key.
*   **Line 23 (`vim.keymap.set("n", "<leader><BS>", "<cmd>e #<cr>", ...)`):** Toggles back and forth between your last two active files using Space+Backspace.
*   **Lines 26-36 (VimEnter Greeting):** Defines an autocommand that prints a welcome banner after the UI draws on startup. You can customize the greeting string inside `vim.api.nvim_echo` or delete this block entirely.

---

#### 🎨 D. Visual Elements & UI Customization: [ui.lua](file:///Users/rohan/.config/nvim/lua/plugins/ui.lua)
This file configures the colorscheme, prompt popups, statusline, tab bar, git indicators, image viewer, and the welcome dashboard.

*   **Lines 2-8 (`require("tokyonight").setup(...)`):** Sets up colorscheme transparency. Change `transparent = true` to `false` if you want a solid background color instead of inheriting your terminal's background.
*   **Line 9 (`vim.cmd([[colorscheme tokyonight-storm]])`):** Specifies the theme flavor. Change `tokyonight-storm` to `tokyonight-night` or `tokyonight-day` (light mode) if desired.
*   **Lines 12-24 (`require("dressing").setup(...)`):** Configures beautiful floating input dialogues. Change `border = "rounded"` to `"single"`, `"double"`, or `"solid"` to modify borders.
*   **Lines 28-39 (Neo-tree Keybinds):** Registers `<leader>fe` (cwd explorer) and `<leader>fE` (file-parent explorer). Change these keys if you want a different explorer shortcut.
*   **Lines 49-71 (Neo-tree File Explorer Options):**
    *   `hide_dotfiles = true` (Line 57): Controls whether dotfiles are hidden by default. Change to `false` to show them.
    *   `hide_gitignored = true` (Line 58): Controls whether git-ignored files are hidden. Change to `false` to show them.
    *   `window.mappings` (Lines 61-70): Overrides keybinds inside the tree panel. Lines 65-68 map `a` and `n` to create files (matching LazyVim style).
*   **Lines 74-92 (`require("lualine").setup(...)`):** Customizes the statusline at the bottom of the screen.
    *   `theme = "tokyonight"` (Line 76): Change the statusline theme to match your style.
    *   `section_separators` / `component_separators` (Lines 78-79): Customizes the statusline block shapes. Change `""` or `""` to normal slashes or pipes if your font doesn't display symbols.
*   **Lines 95-110 (`require("bufferline").setup(...)`):** Configures the tab bar at the top.
    *   `diagnostics = "nvim_lsp"` (Line 97): Displays LSP error icons in the tabs. Set to `false` to turn off tab-level error indicators.
*   **Lines 113-115 (Buffer Navigation):** Maps `Shift+h` and `Shift+l` to cycle tabs, and `<leader>bd` to delete the active tab. Modify these to change how you manage open buffers.
*   **Lines 118-167 (`require("gitsigns").setup(...)`):** Configures git gutter signs and operations.
    *   `signs` (Lines 119-126): Defines custom characters for added, modified, or deleted lines. Change `"▎"` or `""` to modify gutter indicators.
    *   `on_attach` (Lines 127-166): Registers git hotkeys (e.g. `<leader>hp` to preview hunk, `<leader>tb` to toggle line blame). Edit these mappings to customize your Git workflow.
*   **Lines 171-197 (`image.nvim` Setup):**
    *   `backend = "kitty"` (Line 174): Graphics backend protocol. Falls back automatically if you use WezTerm/Ghostty/iTerm2.
    *   `max_height_window_percentage = 50` (Line 190): Controls how tall inline images are relative to your window. Adjust this percentage to make previews larger or smaller.
*   **Lines 200-238 (`alpha-nvim` Welcome Dashboard):**
    *   `dashboard.section.header.val` (Lines 204-213): The ASCII logo. Replace these lines with your own text block!
    *   `dashboard.section.buttons.val` (Lines 216-223): The quick dashboard buttons. Customize the label (2nd argument) and command (3rd argument) to bind your favorite commands.
    *   `stats` (Line 230): The footer text showing package counts. Customize this string to show a custom motivational quote!
    *   `AlphaHeader`, `AlphaButtons`, `AlphaFooter` (Lines 234-236): Defines colors for the dashboard components. Change hex codes (e.g., `#7aa2f7`) to customize the dashboard color palette.

---

#### 📂 E. Productivity Helpers & Search: [editor.lua](file:///Users/rohan/.config/nvim/lua/plugins/editor.lua)
This file integrates fuzzy searching, keybind popups, diagnostic menus, session saving, and file pinning.

*   **Line 2 (`require("nvim-autopairs").setup(...)`):** Initializes auto-closing of brackets and quotes. If you want to configure autopairs behavior, pass options into the setup table.
*   **Lines 6-12 (Telescope Shortcuts):** Registers `<leader>ff` (find files), `<leader>fg` (grep text), `<leader>fb` (buffers), and `<leader>?` (keymap search).
*   **Lines 14-23 (`require("telescope").setup(...)`):**
    *   `mappings.i` (Lines 16-21): Customizes keybinds inside the search dialog. Maps `Ctrl+j` and `Ctrl+k` to move the selection list down/up.
*   **Lines 26-42 (`require("which-key").setup(...)`):** Sets up the keybind popup guide.
    *   `preset = "classic"` (Line 28): Selects the classic bottom-panel style.
    *   `wk.add(...)` (Lines 32-42): Defines names for leader prefixes (e.g. `<leader>b` is grouped as `"buffer"`, `<leader>c` as `"code/lsp"`). Add your own groups here if you create custom keybind categories.
*   **Lines 48-53 (Trouble Diagnostics Keybinds):** Maps `<leader>xx` and `<leader>xX` to toggle the bottom diagnostic panel. You can change these keys to customize how you view compiler errors and warnings.
*   **Lines 59-61 (Session Persistence Keybinds):** Sets up `<leader>qs` (restore session) and `<leader>qd` (disable session saving). Change these if they conflict with other shortcuts.
*   **Lines 68-74 (Harpoon File Pinning Keybinds):** Maps `<leader>ha` to pin a file, `<leader>he` to toggle the pin menu, and `<leader>1` through `4` to jump to pinned files. Change these to customize your rapid file-switching hotkeys.

---

#### 💻 F. Autocompletion & Formatting: [coding.lua](file:///Users/rohan/.config/nvim/lua/plugins/coding.lua)
Configure how the editor suggests text completions and formats your source code.

*   **Lines 6-8 (`experimental = { ghost_text = true }`):** Enables light-grey inline preview text matching the top completion recommendation. Set to `false` to disable ghost text.
*   **Lines 14-38 (Autocomplete Mappings):**
    *   `["<C-Space>"]` (Line 17): Triggers the autocomplete dropdown.
    *   `["<CR>"]` (Line 19): Confirms the selection. Change `select = true` to `false` if you only want Enter to confirm if you've explicitly selected an item.
    *   `["<Tab>"]` / `["<S-Tab>"]` (Lines 20-37): Tab cycles through the autocomplete dropdown list or jumps through placeholders in code snippets. Customize these functions if you prefer different navigation keys.
*   **Lines 39-45 (`sources`):** Defines where autocomplete suggestions come from. Order matters! `nvim_lsp` provides compiler suggestions, `luasnip` provides code snippets, `path` provides file system paths, and `buffer` provides words in the current file.
*   **Lines 49-71 (`formatters_by_ft = { ... }`):** Links file extensions to code formatters.
    *   *How to change formatters:* If you want Python to use `autopep8` instead of `black`, change `python = { "black" }` to `python = { "autopep8" }`.
    *   *How to add a new filetype:* Add a new line. E.g., `go = { "gofmt" }`.
*   **Lines 67-70 (`format_on_save`):** Triggers autoformatting every time you write a file.
    *   `timeout_ms = 500` (Line 68): Maximum time allowed for formatters to run. If a formatter is slow (e.g. Prettier on massive files) and fails to run, increase this to `1000` or `2000`.
    *   `lsp_fallback = true` (Line 69): If no dedicated formatter is installed, fall back to using the active language server's formatter. Set to `false` to prevent fallback.
*   **Lines 74-86 (Format Command & Keymap):** Defines the `:Format` command (supporting range formatting) and binds it to `<leader>cf`.

---

#### ⚙️ G. Language Servers (LSP): [lsp.lua](file:///Users/rohan/.config/nvim/lua/plugins/lsp.lua)
This file installs compiler language servers (LSPs) and wires them to Neovim's native LSP client.

*   **Lines 4-18 (`ensure_installed = { ... }`):** The list of LSPs Mason will automatically download and keep updated.
    *   *How to add a server:* Look up the server name on Mason (e.g., `gopls` for Go, `rust_analyzer` for Rust) and add it to this array.
*   **Lines 22-32 (`LspAttach` Autocommand):** Registers keyboard shortcuts that are active **only** inside files with a running language server.
    *   `gd` (Line 26): Jump to definition.
    *   `K` (Line 27): Show type docs.
    *   `<leader>ca` (Line 28): Open quick-fixes.
    *   `<leader>rn` (Line 29): Project-wide rename.
    *   `gr` (Line 30): List references.
    *   *Customization:* You can change any of these keys to fit your preferences (e.g. change `gd` to `<leader>cd`).
*   **Lines 36-50 (`servers = { ... }`):** Lists LSPs Neovim should activate.
    *   **Crucial Rule:** If you add an LSP to `ensure_installed`, you must also add it to `servers` here so Neovim initializes it!
*   **Lines 53-58 (Initialization Loop):** Configures each server with autocompletion capabilities and enables them.

---

#### 🌳 H. Syntax Highlighting: [treesitter.lua](file:///Users/rohan/.config/nvim/lua/plugins/treesitter.lua)
This file handles advanced syntax highlighting, code folding, and indent calculations.

*   **Lines 3-27 (`ensure_installed = { ... }`):** The list of language parsers that Treesitter will compile and install.
    *   *How to add syntax highlighting:* Add the language parser name (e.g. `"yaml"`, `"rust"`, `"toml"`) to the list.
*   **Line 28 (`highlight = { enable = true }`):** Toggles Treesitter syntax highlighting. Must be `true` for beautiful code colors.
*   **Line 29 (`indent = { enable = true }`):** Tells Treesitter to calculate smart indentation based on syntax trees (rather than generic regexes). Set to `false` if you experience lag in massive source files.

---


### 4. Automatic & Manual Plugin Updates

To keep your Neovim environment up-to-date with the latest features and bug fixes of your 27 installed plugins, this configuration includes a built-in native update system:

*   **Automatic Background Updates:** Every 7 days, Neovim will silently check and pull updates for all your plugins in the background upon startup. Because it runs completely asynchronously, it adds **zero milliseconds of startup lag**—your editor will still open instantly, and you will see a clean progress message at the bottom of the screen only when the updates are complete!
*   **Manual Updates:** You can manually trigger a full update of all your plugins at any time by running the following command in Neovim:
    ```vim
    :PluginUpdate
    ```
    This runs all update tasks in parallel in the background, allowing you to continue coding uninterrupted while it works.

---



## 10. Inline PDF & Image Previews (image.nvim)
Provides high-resolution, inline image and PDF page rendering directly inside your Neovim buffers (such as in Markdown files or when opening images/PDFs directly).

### Compatible Terminal Emulators:
To view inline graphics, you must use a terminal emulator that supports advanced graphics protocols:
*   **WezTerm** (iTerm2/Kitty protocol)
*   **Kitty** (Kitty protocol)
*   **Ghostty** (Kitty protocol)
*   **iTerm2** (iTerm2 protocol)

*Note: The default macOS Terminal app does not support inline graphics.*

### Required System Dependencies:
To enable image and PDF rendering, run the following commands on your system:
1.  **Install ImageMagick & Poppler (macOS):**
    ```bash
    brew install imagemagick poppler
    ```
    *(Poppler is required for `pdftoppm`, which converts PDF pages into images on-the-fly for rendering).*
2.  **Install Lua Magick binding:**
    Ensure you have `luarocks` installed on your system (e.g., `brew install luarocks`) and run:
    ```bash
    luarocks --local --lua-version=5.1 install magick
    ```

*Neovim will boot up perfectly even if these system dependencies are missing, thanks to a protective load check. Previews will activate automatically once the dependencies are installed and you open a supported file.*

---
