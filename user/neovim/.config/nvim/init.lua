local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
	use 'vimwiki/vimwiki'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)


local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local api = vim.api

g.vimwiki_list = {{ path = '~/Documents/vimwiki', syntax = 'markdown', ext = '.md' }}

g.mapleader = [[ ]]
opt.showmode = false

opt.number = true
opt.relativenumber = true
cmd [[
	augroup ToggleInsertNumber
		autocmd!
		autocmd InsertLeave * set relativenumber
		autocmd InsertEnter * set norelativenumber
	augroup END
]]

opt.fsync = true
opt.hidden = true

opt.incsearch = true
opt.inccommand = 'nosplit' -- Preview while replacing
api.nvim_set_keymap('n', '<esc>', [[<cmd>noh<cr>]], { noremap = true, silent = true})

opt.splitright = true
opt.splitbelow = true

opt.tabstop = 4
opt.softtabstop = 0
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smarttab = true

opt.clipboard = 'unnamedplus'
opt.fileformat = 'unix'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.writebackup = true
cmd [[ set backupdir=$XDG_DATA_HOME/nvim/backupdir// ]]

opt.undofile = true
cmd [[ set undodir=$XDG_DATA_HOME/nvim/undodir// ]]

opt.swapfile = true
cmd [[ set dir=$XDG_DATA_HOME/nvim/swapdir// ]]

opt.ignorecase = true
opt.smartcase = true

opt.wrap = false

opt.signcolumn = 'number'
opt.colorcolumn = '80'

cmd [[
    function InlineCommand()
        let l:cmd = input('Command: ')
        let l:output = system(l:cmd)
        let l:output = substitute(l:output, '[\r\n]*$', '', '')
        execute 'normal i'.l:output
    endfunction

    nmap <Leader>ic :call InlineCommand()<CR>
]]
