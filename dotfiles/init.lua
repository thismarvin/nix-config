local keymap = vim.api.nvim_set_keymap

local function execute(expression)
	vim.api.nvim_exec(expression, true)
end

local function has(key)
	return vim.fn.has(key) == 1
end

local function set(expression)
	vim.api.nvim_command(string.format("set " .. expression))
end

-- `vim.keymap.set` polyfill
if vim.keymap == nil then
	vim.keymap = {
		set = function(mode, lhs, rhs, options)
			if options == nil then
				options = {}
			end

			if options.noremap == nil then
				options.noremap = true
			end

			if type(mode) == "table" then
				for k, v in pairs(mode) do
					vim.api.nvim_set_keymap(v, lhs, rhs, options)
				end
			else
				vim.api.nvim_set_keymap(mode, lhs, rhs, options)
			end
		end,
	}
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
set("listchars=tab:┊\\ ,trail:·")
-- set("clipboard=unnamedplus")
set("mouse=a")
set("spelllang=en_us")
set("tabstop=2")
set("shiftwidth=2")
set("scrolloff=4")

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

vim.keymap.set("n", "<Leader>", "<Nop>")
vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "<Leader>w", "<C-w>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<C-Down>", "<Cmd>move .+1<CR>==zz")
vim.keymap.set("n", "<C-Up>", "<Cmd>move .-2<CR>==zz")
vim.keymap.set("i", "<C-Down>", "<Esc><Cmd>move .+1<CR>==a")
vim.keymap.set("i", "<C-Up>", "<Esc><Cmd>move .-2<CR>==a")
vim.keymap.set("v", "<C-Down>", ":move '>+1<CR>gv=gvzz", { silent = true })
vim.keymap.set("v", "<C-Up>", ":move '<-2<CR>gv=gvzz", { silent = true })
vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR><Esc>")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<F12>", "<Cmd>setlocal spell!<CR>")
