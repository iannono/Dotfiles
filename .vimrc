set nocompatible               " be iMproved
set autowrite
set clipboard=unnamed

" 1 tab to 2 space for ruby
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" number line show
set nu

set noswapfile
"in order to switch between buffers with unsaved change
set hidden

" cancel shift+k bind
map <S-k> <Nop>

" hightlight column and line
set cursorline
"set cursorcolumn
filetype plugin indent on
syntax on

" support css word with -
autocmd FileType css,scss,slim,html,eruby,coffee,javascript,wxml setlocal iskeyword+=-
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4

autocmd BufEnter *.png,*.jpg,*gif exec "! open ".expand("%") | :bw

" vim 7.4 backspace fix
set backspace=indent,eol,start
set t_Co=256
" colorscheme, read here: http://vim.wikia.com/wiki/Change_the_color_scheme
" colorscheme gruvbox
autocmd BufWritePre * :%s/\s\+$//e

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'

Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-dispatch'
Plugin 'morhetz/gruvbox'
autocmd vimenter * ++nested colorscheme gruvbox

if has("gui_running")
  " colorscheme desert
  set bs=2
  set ruler
  set gfn=Monaco:h16
  set shell=/bin/bash
endif

let mapleader= ","
" EasyMotion_leader_key .
" Plugin Plugin here for Ruby on Rails
" ruby
Plugin 'vim-ruby/vim-ruby'
" git
Plugin 'tpope/vim-fugitive'
" quickly move cursor, try ,,w
Plugin 'Lokaltog/vim-easymotion'
" quickly write HTML, just like zencoding but simple engough
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"let g:sparkupNextMapping= "<c-m>"
Plugin 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
let g:user_emmet_mode='iv'
autocmd FileType html,css,eruby,xml EmmetInstall
" power vim plugin for rails
Plugin 'tpope/vim-rails.git'
" vim rails syntax complete, try ctrl+x ctrl+u
set completefunc=syntaxcomplete#Complete
" quickly comment your code, try ,cc on selected line
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1
" indent guides
let g:indent_guides_guide_size = 1
Plugin 'nathanaelkane/vim-indent-guides'
" indent guides shortcut
map <silent><F7>  <leader>ig
" markdown support
let g:vim_markdown_folding_disabled = 1
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" file tree like something called IDE
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
map <silent><F8> :NERDTree<CR>
map <leader>r :NERDTreeFind<cr>
map <leader>e :NERDTreeToggle<cr>

" basic dependence
Plugin 'L9'
" slim template support
Plugin 'slim-template/vim-slim.git'
" hack filetype for slim
autocmd BufNewFile,BufRead *.slim set filetype=slim
autocmd BufNewFile,BufRead *.es6 set filetype=javascript
autocmd BufNewFile,BufRead *.json.jb set filetype=ruby
autocmd BufNewFile,BufRead *.wxml set filetype=xml
autocmd BufNewFile,BufRead *.wxss set filetype=css

" quickly search file(s), use fzf.vim
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
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
Plugin 'JulesWang/css.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'isRuslan/vim-es6'

Plugin 'zerowidth/vim-copy-as-rtf'

" auto-switch input source to en for normal mode
" see here for install:  https://github.com/xcodebuild/fcitx-remote-for-osx
Plugin 'CodeFalling/fcitx-vim-osx'

Plugin 'chemzqm/wxapp.vim'
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
call vundle#end()


"" Custom Mapping
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap ff <esc>
inoremap ff <esc>

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
nnoremap <silent><leader>2 :e ~/.vimrc<CR>
" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PluginInstall<CR>

" terminal
inoremap <leader>tm :terminal<CR>
nnoremap <leader>tm :terminal<CR>

" vim-go
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
