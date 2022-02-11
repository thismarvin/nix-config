-- Setup some utility functions.
local function set(expression)
	vim.api.nvim_command(string.format("set " .. expression))
end

local function execute(expression)
	vim.api.nvim_exec(expression, true)
end

-- Implement a crude `vim.keymap.set` polyfill.
if vim.keymap == nil then
	vim.keymap = {
		set = function(mode, lhs, rhs, options)
			if options == nil then
				options = {}
			end

			if options.noremap == nil then
				options.noremap = true
			end

			if options.remap ~= nil and options.remap == true then
				options.noremap = false
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

set("relativenumber")
set("noshowmode")
set("confirm")
set("noswapfile")
set("undofile")
set("smartindent")
set("ignorecase")
set("smartcase")
set("splitbelow")
set("splitright")
set("list")
set("listchars=tab:┊\\ ,trail:·")
set("mouse=a")
set("spelllang=en_us")
set("tabstop=2")
set("softtabstop=2")
set("shiftwidth=2")
set("scrolloff=4")

execute([[
augroup vimrc
  autocmd!
  " Only show the cursor line when in insert mode.
  " autocmd InsertEnter * set cursorline
  " autocmd InsertLeave * set nocursorline
  " After yanking a selection, highlight the selection for a bit.
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='Visual', timeout=200 }
augroup end
]])

vim.g.mapleader = " "

vim.keymap.set("n", "<Leader>", "<Nop>")
vim.keymap.set("n", "U", "<C-r>")
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

-- netrw configuration.
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- nvim-treesitter configuration.
require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	ignore_install = { "norg" },
	highlight = {
		enable = true,
	},
})

-- comment-nvim configuration.
require("Comment").setup()

-- telescope.nvim configuration.
require("telescope").setup({
	defaults = {
		dynamic_preview_title = true,
		path_display = { "smart" },
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				width = 0.8,
				height = 0.9,
			},
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
})

-- nvim-lspconfig configuration.
set("nobackup")
set("nowritebackup")
set("updatetime=250")
set("shortmess+=c")
set("signcolumn=yes")
