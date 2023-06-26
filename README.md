# webify.nvim

Neovim plugin that opens the current file in the remote's web interface or yanks its URL.

# Motivation

Virtually all software projects are managed using git and hosted on collaboration platforms like github or gitlab: "the remote".
Such platforms offer a web interface to navigate the source code, review the history and much more.

Often when working on Neovim I have the need to jump to the current file in the web browser or yank its URL to be shared with someone.
`webify.nvim` builds a bridge between the current file and the repo's web interface by opening the current file in the remote's web interface or yanking its URL.

# Installation

## Packer

```
use "pabloariasal/webify.nvim"
```

# Usage

## Opening files in a web browser

Open the current file in the remote using the default web browser:

```lua
:OpenFileInRepo
```

Same as above, but also include the current line:

```lua
:OpenLineInRepo
```


## Yanking remote URL of the current file

Yank the remote URL to the system clipboard on register '+' ([see :help registers](https://vimdoc.sourceforge.net/htmldoc/change.html#registers))

```lua
:YankFileUrl +
```

same as above, but yank URL including current line number:


```lua
:YankLineUrl +
```

## Defining Keybindings

```lua
vim.keymap.set('n', '<leader>o', '<cmd>OpenFileInRepo<cr>', { desc = 'Open in web browser'})
vim.keymap.set('n', '<leader>O', '<cmd>OpenLineInRepo<cr>', { desc = 'Open in web browser, including current line'})
vim.keymap.set('n', '<leader>y', '<cmd>YankFileUrl +<cr>', { desc = 'Yank Url to system clipboard'})
vim.keymap.set('n', '<leader>Y', '<cmd>YankLineUrl +<cr>', { desc = 'Yank Url to system clipboard, including current line'})
```

# Limitations

* Currently only works on Linux as it uses `xdg-open` and I have no means to test on other OSes (MRs welcome)
* Only tested on github and gitlab

# Contributing

## Running Tests

You must have [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) installed to run the tests.

```sh
cd webify.nvim
nvim test/url_utils_test.lua
```
And then run

```sh
:PlenaryBustedFile %
```
