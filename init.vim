" ~/.config/nvim/init.vim
syntax on
set number
set relativenumber
set smarttab
set ignorecase
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set clipboard+=unnamed  " use the clipboards of vim and win
set go+=a               " Visual selection automatically copied to the clipboard
set mouse-=a
set encoding=utf-8
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set foldmethod=indent
set nofoldenable
set foldlevel=2

" set tabs width 4 when file type is python
autocmd Filetype py setlocal shiftwidth=4 tabstop=4
" set tabs width 4 when file type is golang
autocmd Filetype go setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab

filetype plugin indent on

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" ================= looks and basic stuff ================== "

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim' " for autocomplete html:5
Plug '1995parham/tomorrow-night-vim' " theme for vim
Plug 'hail2u/vim-css3-syntax' " syntax highlighting css3
Plug 'ap/vim-css-color' " css3 color
Plug 'jiangmiao/auto-pairs' " tag autopairs like (),[],{} etc.
Plug 'alvan/vim-closetag' " auto close html tag
Plug 'vim-python/python-syntax' " python syntax highlighting
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " to highlight files in nerdtree
" NOTE: go to https://github.com/ryanoasis/vim-devicons to more information
" how to install icons in linux
Plug 'ryanoasis/vim-devicons' " icon for vim
Plug 'glench/vim-jinja2-syntax' " styling jinja2 syntax
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'branch': 'release/0.x',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'php'] }
Plug 'posva/vim-vue' " syntax highlighting for vue
Plug 'maxmellon/vim-jsx-pretty' " syntax highlighting for jsx
Plug 'ekalinin/Dockerfile.vim' " syntax highlighting Dockerfile
Plug 'chr4/nginx.vim' " syntax highlighting nginx
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " syntax highlighting golang
" ================= Functionalities ================= "

" autocompletion using ncm2 
Plug 'ncm2/ncm2' " dependency of ncm2
Plug 'roxma/nvim-yarp' " awesome autocomplete plugin
Plug 'othree/csscomplete.vim' " css autocomplete for ncm2
" autocomplete for python
Plug 'davidhalter/jedi-vim'
Plug 'ncm2/ncm2-jedi'
" enable css completion in file javascript
Plug 'ncm2/ncm2-html-subscope'
Plug 'dense-analysis/ale' " syntax checking and semantic errors

" search plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'unkiwii/vim-nerdtree-sync' " for synchronizing current open file with NERDtree

" autocomplete for javascript
" NOTE: :CocInstall coc-json coc-tsserver coc-vetur coc-docker coc-go, run in command mode after installing coc.nvim
" more information: https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary' " commentary in vim
Plug 'voldikss/vim-floaterm' " vim terminal in the floating/popup window.
Plug 'liuchengxu/vim-which-key' " displays available keybindings in popup
" Synchronize all Ranger's configuration and plugins with Rnvimr
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

call plug#end()
" List ends here. Plugins become visible to Vim after this call.

let mapleader = ","

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" By default timeoutlen is 1000 ms
set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['m'] = [':e $MYVIMRC', 'vim setting']
let g:which_key_map['t'] = [':NERDTreeToggle', 'nerdtree']
let g:which_key_map['p'] = [':PrettierAsync', 'prettier js']
let g:which_key_map['l'] = [':GFiles', 'fzf git']
let g:which_key_map[';'] = [':Files', 'fzf file']

let g:which_key_map['w'] = {
      \ 'name' : 'terminal' ,
      \ ';' : [':FloatermNew', 'terminal'],
      \ 'p' : [':FloatermNew python3', 'python'],
      \ 'r' : [':RnvimrToggle', 'ranger'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")

" Floatterm settings
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

" float term scroll press double esc
if has("nvim")
  " Make escape work in the Neovim terminal.
  tnoremap <Esc> <C-\><C-n>

  " Make navigation into and out of Neovim terminal splits nicer.
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l

  " I like relative numbering when in normal mode.
  autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 relativenumber

  " Prefer Neovim terminal insert mode to normal mode.
  autocmd BufEnter term://* startinsert
endif

" Ranger Settings
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_bw_enable = 1
let g:rnvimr_ranger_cmd = 'ranger --cmd="set preview_images_method w3m"'
let g:rnvimr_presets = [{'width': 0.8, 'height': 0.8}]

" path to your python 
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

let NERDTreeShowHidden=1 " show hidden file in nerd tree
let NERDTreeIgnore=['\.DS_Store$', '\.git$','^env$', '__pycache__'] " ignore files in nerd tree
let g:NERDTreeWinSize=28 " nerdtree size
" unkiwii/vim-nerdtree-sync options
let g:nerdtree_sync_cursorline = 1
let g:NERDTreeHighlightCursorline = 1

" set color scheme to 1995parham/tomorrow-night-vim
colorscheme naz
" make colorscheme transparent
hi Normal guibg=NONE ctermbg=NONE

" change color to none when vertical split
highlight VertSplit ctermfg=NONE
highlight VertSplit ctermbg=NONE
" color relativenumber
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" init setting for hail2u/vim-css3-syntax
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

" coc.nvim options
let g:coc_disable_startup_warning = 1
" posva/vim-vue options 
let g:vue_pre_processors = 'detect_on_enter'

" NOTE: to customize preview window color in fzf
" 1. install bat in official web : https://github.com/sharkdp/bat
" 2. export BAT_THEME="Dracula", or add to ~/.zshrc in my case
" 3. see all list theme : bat --list-themes, run in your terminal

"Border color for fzf
let g:fzf_layout = 
      \ {'up':'~90%', 
      \ 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

" init vim-python/python-syntax plugin
let g:python_highlight_all = 1

" NCM SETTINGS
" NOTE: when launch neovim given following error like this [ncm2_core@yarp] Job is dead.
" RUN: sudo pip3 install --upgrade neovim, tested on ubuntu 18.04
" NOTE: required install jedi from pip when use autocomplete ncm2-jedi
" RUN: sudo pip3 install jedi
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <c-c> <ESC>
" init css complete for ncm2
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })
" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1,1]]

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = 1

" ALE SETTINGS
" RUN: sudo pip3 install flake8
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '∙∙'
let g:ale_python_flake8_options = '--ignore=E302,E231,E501,E701,E401,E128,E251,F403,F405,E402,E221,W504,F722'

let g:ale_list_window_size = 8
let g:ale_sign_column_always = 0
let g:ale_open_list = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.php,*.jsx,*.js'
" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,js'
" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1
" dict
" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

" Max line length that prettier will wrap on: a number or 'auto' (use
" textwidth).
" default: 'auto'
let g:prettier#config#print_width = 100
" number of spaces per indentation level: a number or 'auto' (use
" softtabstop)
" default: 'auto'
let g:prettier#config#tab_width = 2
" use tabs instead of spaces: true, false, or auto (use the expandtab setting).
" default: 'auto'
let g:prettier#config#use_tabs = 'false'
" Use single quotes instead of double quotes.
" default: 'false'
" See more: https://prettier.io/docs/en/options.html#quotes
let g:prettier#config#single_quote = 'false'
" print spaces between brackets
" default: 'true'
" See more: https://prettier.io/docs/en/options.html#bracket-spacing
let g:prettier#config#bracket_spacing = 'true'
" put > on the last line instead of new line
" default: 'false'
" See more: https://prettier.io/docs/en/options.html#jsx-brackets
let g:prettier#config#jsx_bracket_same_line = get(g:,'prettier#config#jsx_bracket_same_line', 'false')
" avoid wrapping a single arrow function param in parens
" avoid|always
" default: 'always'
" See more: https://prettier.io/docs/en/options.html#arrow-function-parentheses
let g:prettier#config#arrow_parens = get(g:,'prettier#config#arrow_parens', 'always')

" VIM-JSX-PRETTY SETTINGS
let g:vim_jsx_pretty_template_tags = ['html', 'jsx', 'js']
let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1

"Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" disable all mouse wheel
nmap <ScrollWheelUp> <nop>
nmap <S-ScrollWheelUp> <nop>
nmap <C-ScrollWheelUp> <nop>
nmap <ScrollWheelDown> <nop>
nmap <S-ScrollWheelDown> <nop>
nmap <C-ScrollWheelDown> <nop>
nmap <ScrollWheelLeft> <nop>
nmap <S-ScrollWheelLeft> <nop>
nmap <C-ScrollWheelLeft> <nop>
nmap <ScrollWheelRight> <nop>
nmap <S-ScrollWheelRight> <nop>
nmap <C-ScrollWheelRight> <nop>

imap <ScrollWheelUp> <nop>
imap <S-ScrollWheelUp> <nop>
imap <C-ScrollWheelUp> <nop>
imap <ScrollWheelDown> <nop>
imap <S-ScrollWheelDown> <nop>
imap <C-ScrollWheelDown> <nop>
imap <ScrollWheelLeft> <nop>
imap <S-ScrollWheelLeft> <nop>
imap <C-ScrollWheelLeft> <nop>
imap <ScrollWheelRight> <nop>
imap <S-ScrollWheelRight> <nop>
imap <C-ScrollWheelRight> <nop>

vmap <ScrollWheelUp> <nop>
vmap <S-ScrollWheelUp> <nop>
vmap <C-ScrollWheelUp> <nop>
vmap <ScrollWheelDown> <nop>
vmap <S-ScrollWheelDown> <nop>
vmap <C-ScrollWheelDown> <nop>
vmap <ScrollWheelLeft> <nop>
vmap <S-ScrollWheelLeft> <nop>
vmap <C-ScrollWheelLeft> <nop>
vmap <ScrollWheelRight> <nop>
vmap <S-ScrollWheelRight> <nop>
vmap <C-ScrollWheelRight> <nop>

" disable arrow key
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" disable page down and up
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>

nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>

vnoremap <PageUp> <Nop>
vnoremap <PageDown> <Nop>
