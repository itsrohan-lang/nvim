# Custom Neovim Configuration

A clean, modern, and high-performance custom Neovim configuration utilizing Neovim's built-in native package manager. It includes native LSP integration, treesitter syntax highlighting, fuzzy finding via Telescope, a fully featured file explorer, an interactive statusline, a visual buffer/tab bar, git gutter integrations, a popup keymap helper, automatic formatting on save, a beautiful diagnostics panel, an interactive welcome dashboard, workspace session persistence, and quick file pinning via Harpoon.

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

## Ergonomic Editing & Navigation
Highly productive editing utilities and comfortable navigation helpers that reduce eye strain and speed up text manipulation.

| Keybind | Action | Description |
|---|---|---|
| `Ctrl + d` | **Scroll Down & Center** | Page-down through your file and automatically lock the cursor in the center of the screen |
| `Ctrl + u` | **Scroll Up & Center** | Page-up through your file and automatically lock the cursor in the center of the screen |
| `n` | **Next Match & Center** | Jump to the next search match and lock the cursor in the center of the screen |
| `N` | **Prev Match & Center** | Jump to the previous search match and lock the cursor in the center of the screen |
| `J` (Visual Mode) | **Drag Selection Down** | Slide the selected block of code down one line and auto-indent it |
| `K` (Visual Mode) | **Drag Selection Up** | Slide the selected block of code up one line and auto-indent it |
| `<leader>y` (Space + y) | **Copy to System Clipboard** | Yank selection (or current movement) directly to your OS system clipboard |
| `<leader><BS>` (Space + Backspace) | **Toggle Last Active File** | Instantly toggle back and forth between your last two active files |

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
* `a` or `n` — **Create File/Folder:** Hover over a directory, press `a` (LazyVim default) or `n`, and enter the name in the centered floating prompt. End with `/` to create a directory (e.g., `src/`), or omit the slash to create a file (e.g., `app.js`).
* `A` or `N` — **Create Directory:** Hover over a directory, press `A` or `N`, and enter the directory name to create it.
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

## 11. Workspace Session Persistence (persistence.nvim)
Automatically saves your open tabs, buffers, and window splits when you exit Neovim in a project folder, and allows you to restore them instantly upon reopening.

You can also trigger a restore directly from the **Welcome Dashboard** using the `s` key!

| Keybind | Action | Description |
|---|---|---|
| `<leader>qs` | **Restore Session** | Restore the saved session for the current working directory |
| `<leader>ql` | **Restore Last Session** | Restore the last active session globally |
| `<leader>qd` | **Don't Save Session** | Disable session saving for the current Neovim execution |

---

## 12. Quick File Pinning & Switching (harpoon2)
Allows you to pin your 3-4 most-used files in a project and switch between them instantly using single-key shortcuts, bypassing tabs and search lists.

| Keybind | Action | Description |
|---|---|---|
| `<leader>ha` | **Harpoon File** | Pin the current file to the Harpoon list |
| `<leader>he` | **Harpoon Menu** | Toggle the interactive quick menu to view and organize pinned files |
| `<leader>1` | **Select File 1** | Instantly switch to the 1st pinned file |
| `<leader>2` | **Select File 2** | Instantly switch to the 2nd pinned file |
| `<leader>3` | **Select File 3** | Instantly switch to the 3rd pinned file |
| `<leader>4` | **Select File 4** | Instantly switch to the 4th pinned file |

