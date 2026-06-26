# Custom Neovim Configuration

A clean, modern, and high-performance custom Neovim configuration built on top of `lazy.nvim`. It includes native LSP integration, treesitter syntax highlighting, fuzzy finding via Telescope, and a fully featured file explorer.

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

## 4. Auto-Completion (nvim-cmp)
Automatic popup completions as you type.

| Keybind | Action | Description |
|---|---|---|
| `Tab` | **Next / Expand** | Select the next completion item, or expand/jump forward in a snippet |
| `Shift + Tab` | **Prev / Jump Back** | Select the previous completion item, or jump backward in a snippet |
| `Ctrl + Space` | **Trigger** | Manually open the completion menu |
| `Ctrl + e` | **Close** | Abort and close the completion menu |
| `Enter` | **Confirm** | Insert the currently selected item |
