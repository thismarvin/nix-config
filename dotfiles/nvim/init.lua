local map = vim.api.nvim_set_keymap

function execute(expression)
	vim.api.nvim_exec(expression, true)
end

function has(key)
	return vim.fn.has(key) == 1
end

function set(expression)
	vim.api.nvim_command(string.format("set " .. expression))
end

set("number")
set("nowrap")
set("noshowmode")
set("confirm")
set("autoread")
set("noswapfile")
set("undofile")
set("smartindent")
set("ignorecase")
set("smartcase")
set("splitbelow")
set("splitright")
set("list")
set("listchars=tab:\\ ,trail:·")
set("clipboard=unnamedplus")
set("mouse=a")
set("spelllang=en_us")
set("tabstop=2")
set("shiftwidth=2")

execute([[
augroup vimrc
  autocmd!
  " Only show the cursor line when in insert mode.
  autocmd InsertEnter * set cursorline
  autocmd InsertLeave * set nocursorline

  " After yanking a selection, highlight the selection for a bit.
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='Visual', timeout=200 }
augroup end
]])

vim.g.mapleader = " "

map("n", "<Leader>", "<Nop>", { noremap = true })

map("n", ";", ":", { noremap = true })
map("v", ";", ":", { noremap = true })
map("n", "U", "<C-r>", { noremap = true })
map("n", "<Leader>w", "<C-w>", { noremap = true })
map("v", "<", "<gv", { noremap = true })
map("v", ">", ">gv", { noremap = true })
map("n", "<Esc>", "<Cmd>noh<CR><Esc>", { noremap = true, silent = true })
map("n", "n", "nzz", { noremap = true })
map("n", "N", "Nzz", { noremap = true })
map("n", "<C-i>", "<C-i>zz", { noremap = true })
map("n", "<C-o>", "<C-o>zz", { noremap = true })
map("n", "Y", "y$", { noremap = true })
map("n", "<Leader>cd", "<Cmd>cd %:p:h<CR><Cmd>echo 'Set working directory to:' expand('%:p:h')<CR>", {
	noremap = true,
})
map("n", "<F12>", ":setlocal spell!<CR>", { noremap = true, silent = true })

