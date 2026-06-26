# Custom Neovim Configuration

A clean, modern, and high-performance custom Neovim configuration utilizing Neovim's built-in native package manager. It includes native LSP integration, treesitter syntax highlighting, fuzzy finding via Telescope, a fully featured file explorer, an interactive statusline, a visual buffer/tab bar, git gutter integrations, a popup keymap helper, automatic formatting on save, and a beautiful diagnostics panel.

* **Leader Key:** `Space` (represented as `<leader>` below)

---

## General Window Navigation
Quickly switch focus between splits (e.g., between the file explorer and the file editor).

| Keybind | Action | Description |
|---|---|---|
| `Ctrl + h` | **Move to Left Window** | Switches focus to the file explorer (or any split on the left) |
| `Ctrl + l` | **Move to Right Window** | Switches focus to the file editor (or any split on the right) |
| `Ctrl + j` | **Move to Lower Window** | Switches focus to the window below |
| `Ctrl + k` | **Move to Upper Window** | Switches focus to the window above |
| `Ctrl + w` then `w` | **Cycle Windows** | Neovim's default way to cycle focus through all open splits |

---

## 1. Workspace Searching (Telescope)
Fuzzy-find files, search code text, and manage buffers across your workspace.

| Keybind | Action | Description |
|---|---|---|
| `<leader>ff` or `<leader><Space>` | **Find Files** | Fuzzy-search any file in your project by name |
| `<leader>fg` | **Live Grep** | Search for specific text inside all files in your project |
| `<leader>fb` | **Find Buffers** | List and fuzzy-search all currently open files |
| `<leader>fh` | **Find Help** | Search Neovim's help documentation |
| `<leader>?` or `<leader>sk` | **Search Keymaps** | Interactive, searchable popup of all active keyboard shortcuts |

### Navigation Inside Telescope Menu:
* `Ctrl + j` — Move selection down
* `Ctrl + k` — Move selection up
* `Enter` — Open selected file

---

## 2. File Explorer (Neo-tree)
Manage files, directories, git status, and open buffers.

| Keybind | Action | Description |
|---|---|---|
| `<leader>e` or `<leader>fe` | **Toggle Explorer (Root)** | Opens/closes the explorer focused on your project's root directory |
| `<leader>E` or `<leader>fE` | **Toggle Explorer (File)** | Opens/closes the explorer focused on the current file's directory |
| `<leader>ge` | **Git Explorer** | Opens a panel showing only your modified/untracked Git files |
| `<leader>be` | **Buffer Explorer** | Opens a panel showing all your active buffers |

### Navigation & Management Inside Neo-tree:
* `n` — **Create File/Folder:** Hover over a directory, press `n`, type a filename (e.g. `app.js`) or a folder name ending with `/` (e.g. `src/`).
* `N` — **Create Directory:** Hover over a directory, press `N`, and type the folder name to create it.
* `d` — **Delete:** Delete the hovered file or directory.
* `r` — **Rename:** Rename the hovered file or directory.
* `y` — **Copy Name:** Copy the name of the file/folder to the system clipboard.
* `Y` — **Copy Path:** Copy the relative path of the file/folder to the system clipboard.
* `c` / `x` / `p` — **Copy / Cut / Paste:** Copy or cut a file, and paste it under the hovered directory.
* `H` — **Toggle Hidden Files:** Show or hide dotfiles (e.g. `.env`) and git-ignored folders (e.g. `node_modules`).
* `/` — **Buffer Search:** Jumps to and highlights matching text in the explorer panel without hiding other files.

---

## 3. Language Server Protocol (LSP)
Advanced code intelligence, diagnostics, and navigation. Runs automatically for supported languages.

| Keybind | Action | Description |
|---|---|---|
| `gd` | **Go to Definition** | Jump to where the hovered function or variable is defined |
| `K` | **Hover Docs** | Show type signatures, parameters, and documentation in a popup |
| `gr` | **Go to References** | List all files and lines where the hovered symbol is used |
| `<leader>rn` | **Rename Symbol** | Safely rename the hovered variable/function across your entire project |
| `<leader>ca` | **Code Actions** | Trigger quick-fixes, automatic imports, and refactoring suggestions |

---

## 4. Auto-Completion & Inline Ghost Text (nvim-cmp)
Automatic dropdown completions and inline ghost text previews.

As you type, a pop-up menu will appear. The top suggestion is also displayed directly in your code as light-grey **inline ghost text**.

| Keybind | Action | Description |
|---|---|---|
| `Tab` | **Next / Expand** | Select the next completion item, or expand/jump forward in a snippet |
| `Shift + Tab` | **Prev / Jump Back** | Select the previous completion item, or jump backward in a snippet |
| `Ctrl + Space` | **Trigger** | Manually open the completion menu |
| `Ctrl + e` | **Close** | Abort and close the completion menu |
| `Enter` | **Confirm** | Insert the currently selected item |

---

## 5. Buffer Navigation & Tabline (bufferline.nvim)
A visual tab bar at the top of your editor displaying all open files (buffers) with language icons and diagnostics.

| Keybind | Action | Description |
|---|---|---|
| `Shift + h` | **Previous Buffer** | Switch to the previous open file/buffer |
| `Shift + l` | **Next Buffer** | Switch to the next open file/buffer |
| `<leader>bd` | **Delete Buffer** | Close/delete the current file/buffer without closing your window split |

---

## 6. Git Gutter & Integration (gitsigns.nvim)
Real-time, colored git diff indicators in the left sign column (gutter) and interactive git operations.

### Git Gutter Indicators:
* `▎` (Green) — Line added
* `▎` (Yellow) — Line modified
* `` (Red) — Line deleted
* `░` (Grey) — Mixed change/delete

### Git Keybinds:
| Keybind | Action | Description |
|---|---|---|
| `]c` | **Next Hunk** | Jump to the next changed block of code |
| `[c` | **Prev Hunk** | Jump to the previous changed block of code |
| `<leader>hs` | **Stage Hunk** | Stage the changed block of code under the cursor |
| `<leader>hr` | **Reset Hunk** | Discard/revert the changed block of code under the cursor |
| `<leader>hS` | **Stage Buffer** | Stage all changes in the current file |
| `<leader>hu` | **Undo Stage** | Undo the last staged hunk |
| `<leader>hR` | **Reset Buffer** | Discard/revert all changes in the current file |
| `<leader>hp` | **Preview Hunk** | Show a floating popup containing the git diff for the current hunk |
| `<leader>hb` | **Blame Line** | Show git blame information (author, commit, date) for the current line |
| `<leader>tb` | **Toggle Blame** | Toggle virtual text showing git blame at the end of the current line |
| `<leader>hd` | **Diff Index** | View diff of the current file against the git index |
| `<leader>hD` | **Diff Commit** | View diff of the current file against the last commit |
| `<leader>td` | **Toggle Deleted** | Toggle inline display of deleted lines |

---

## 7. Keymap Helper (which-key.nvim)
A clean, interactive popup panel at the bottom of the screen that automatically appears when you press a prefix key (like `<leader>`, `g`, or `z`), displaying all available keybinds and their descriptions.

Simply press `<leader>` (Space) or any other prefix key and wait for a second to see the interactive menu of all registered keymap prefixes and actions!

---

## 8. Auto-Formatting on Save (conform.nvim)
A lightweight formatter runner that automatically runs industry-standard formatters every time you save a file (`:w`), or manually via a keybind.

### Configured Formatters:
* **Lua:** StyLua (`stylua`)
* **JavaScript / TypeScript / HTML / CSS / JSON / Markdown:** Prettier (`prettier`/`prettierd`)
* **Python:** Black (`black`)
* **Shell Scripts:** shfmt (`shfmt`)
* **Rust:** rustfmt (`rustfmt`)
* **Go:** gofmt, goimports

### Keybinds:
| Keybind | Action | Description |
|---|---|---|
| `<leader>cf` | **Format Code** | Manually formats the current buffer or visually selected range |

---

## 9. Diagnostics Panel (trouble.nvim)
A beautiful, interactive split panel at the bottom of your screen listing all syntax errors, warnings, and hints in your project.

| Keybind | Action | Description |
|---|---|---|
| `<leader>xx` | **Workspace Diagnostics** | Toggle the Trouble panel showing errors in the entire project |
| `<leader>xX` | **Buffer Diagnostics** | Toggle the Trouble panel showing errors in the current active file |
| `<leader>cs` | **Symbols** | Toggle a sidebar showing document symbols (functions, classes, variables) |
| `<leader>cl` | **LSP Definitions/References** | Toggle a panel showing LSP definitions, references, and implementations |
| `<leader>xL` | **Location List** | Toggle Neovim's location list in Trouble |
| `<leader>xQ` | **Quickfix List** | Toggle Neovim's quickfix list in Trouble |
