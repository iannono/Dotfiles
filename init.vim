set nocompatible               " be iMproved
set autowrite
set clipboard=unnamed
let mapleader= ","

" 1 tab to 2 space for ruby
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
autocmd Filetype go setlocal ts=4 sw=4 expandtab
" number line show
set nu

set noswapfile
"in order to switch between buffers with unsaved change
set hidden

" cancel shift+k bind
map <S-k> <Nop>

" hightlight column and line
set cursorline
" set cursorcolumn
filetype plugin indent on
syntax on

" support css word with -
autocmd FileType css,scss,slim,html,eruby,coffee,javascript,wxml setlocal iskeyword+=-
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4

autocmd BufEnter *.png,*.jpg,*gif exec "! open ".expand("%") | :bw

" vim 7.4 backspace fix
set backspace=indent,eol,start
" set t_Co=256
autocmd BufWritePre * :%s/\s\+$//e

" Plugin
call plug#begin(stdpath('data') . '/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'

Plug 'tpope/vim-sensible'
Plug 'nvim-lua/completion-nvim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'

" EasyMotion_leader_key .
" Plugin Plugin here for Ruby on Rails
" ruby
Plug 'vim-ruby/vim-ruby'
" git
Plug 'tpope/vim-fugitive'
" quickly move cursor, try ,,w
Plug 'Lokaltog/vim-easymotion'
" quickly write HTML, just like zencoding but simple engough
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"let g:sparkupNextMapping= "<c-m>"
Plug 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
let g:user_emmet_mode='iv'
autocmd FileType html,css,eruby,xml EmmetInstall
" power vim plugin for rails
Plug 'tpope/vim-rails'
" vim rails syntax complete, try ctrl+x ctrl+u
set completefunc=syntaxcomplete#Complete
" quickly comment your code, try ,cc on selected line; ,c<space>
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1
" indent guides
let g:indent_guides_guide_size = 1
Plug 'nathanaelkane/vim-indent-guides'
" indent guides shortcut
map <silent><F7>  <leader>ig
" markdown support
let g:vim_markdown_folding_disabled = 1
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" file tree like something called IDE
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
map <silent><F8> :NERDTree<CR>
map <leader>er :NERDTreeFind<cr>
map <leader>e :NERDTreeToggle<cr>

" basic dependence
Plug 'L9'
" slim template support
Plug 'slim-template/vim-slim'
" hack filetype for slim
autocmd BufNewFile,BufRead *.slim set filetype=slim
autocmd BufNewFile,BufRead *.es6 set filetype=javascript
autocmd BufNewFile,BufRead *.json.jb set filetype=ruby
autocmd BufNewFile,BufRead *.wxml set filetype=xml
autocmd BufNewFile,BufRead *.wxss set filetype=css

" quickly search file(s), use fzf.vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_history_dir = '~/.local/share/fzf-history'
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-f> :Files<Cr>
nnoremap <C-b> :Buffers<Cr>

" `brew install ripgrep` before you use rg command
nnoremap <C-u> :Rg<Cr>
nnoremap <silent> <C-k> :call SearchWordWithRg()<CR>
vnoremap <silent> <C-k> :call SearchVisualSelectionWithRg()<CR>

if executable('rg')
  let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{.git,node_modules}/*" 2>/dev/null'

endif

function! SearchWordWithRg()
  execute 'Rg' expand('<cword>')
endfunction

function! SearchVisualSelectionWithRg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Rg' selection
endfunction

" sass highlight
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'isRuslan/vim-es6'

Plug 'zerowidth/vim-copy-as-rtf'

" auto-switch input source to en for normal mode
" see here for install:  https://github.com/xcodebuild/fcitx-remote-for-osx
Plug 'CodeFalling/fcitx-vim-osx'

Plug 'chemzqm/wxapp.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plugin 'SirVer/ultisnips'
call plug#end()


"" Custom Mapping
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap fd <esc>
inoremap fd <esc>
inoremap <S-j> <esc>o
inoremap <S-k> <esc>O

noremap Y y$
noremap n nzzzv
noremap N Nzzzv
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


"" Erb
inoremap <leader>= <%=  %><esc>hhi
inoremap <leader>- <%  %><esc>hhi
nnoremap <leader>= i<%=  %><esc>hhi
nnoremap <leader>- i<%  %><esc>hhi

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

"" Rails
inoremap <leader>rm :Emodel
nnoremap <leader>rm :Emodel
inoremap <leader>rc :Econtroller
nnoremap <leader>rc :Econtroller
inoremap <leader>rv :Eview
nnoremap <leader>rv :Eview
inoremap <leader>rh :Ehelper
nnoremap <leader>rh :Ehelper
inoremap <leader>rs :Espec
nnoremap <leader>rs :Espec


" Faster saving and exiting
nnoremap <silent><leader>w :w!<CR>
nnoremap <silent><leader>q :q!<CR>
nnoremap <silent><leader>x :x<CR>
" Open Vim configuration file for editing
nnoremap <silent><leader>2 :e ~/.config/nvim/init.vim<CR>
" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>

" terminal
inoremap <leader>tm :terminal<CR>
nnoremap <leader>tm :terminal<CR>

" vim-go
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'
" let g:go_auto_type_info = 1
" let g:go_auto_sameids = 0

" tab

" GoPls
lua << EOF
require'lspconfig'.solargraph.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.gopls.setup{}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "json",
    "yaml",
    "html",
    "scss"
  },
}
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  require'completion'.on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --...
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end
nvim_lsp.gopls.setup {
  on_attach = on_attach
}
nvim_lsp.tsserver.setup {
  on_attach = on_attach
}

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}

local saga = require 'lspsaga'
saga.init_lsp_saga {
  error_sign = '💀',
  warn_sign = '👾',
  hint_sign = '👀',
  infor_sign = '🔍',
  border_style = "round",
}

vim.fn.sign_define('LspDiagnosticsSignError', { text = "»", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "»", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = "»", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = "»", texthl = "LspDiagnosticsDefaultHint" })

local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'solarized_dark',
    section_separators = {'|', '|'},
    component_separators = {'~', '~'},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = '👾', warn = '💀', info = '👀', hint = '👓'} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}
EOF
set completeopt=menuone,noinsert,noselect
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"



" Telescope
nnoremap <silent> ;f <cmd>Telescope find_files<cr>
nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

" lspsaga
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>

" Tabline
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'
    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSep#>'
    elseif i + 2 == tabpagenr()
      let s .= '%#TabLineSep2#>'
    else
      let s .= '>>'
    endif
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999X'
  endif
  return s
endfunction
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let name = bufname(buflist[winnr - 1])
  let label = fnamemodify(name, ':t')
  return len(label) == 0 ? '[No Name]' : label
endfunction
set tabline=%!MyTabLine()

" colorscheme, read here: http://vim.wikia.com/wiki/Change_the_color_scheme
autocmd vimenter * ++nested colorscheme gruvbox
" let g:gruvbox_italic=1
colorscheme gruvbox
" set termguicolors
set background=dark
set guifont=JetBrains\ Mono\ NL:h16
