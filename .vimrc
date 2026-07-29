"------------------- Vim settings -----------------------
" TODO list:
" remap Ctr + j
" ------------------
" autosave view
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set encoding=UTF-8
set shell=/usr/bin/zsh
set clipboard=unnamedplus           " use system clipboard
set tags+=gems.tags                 " ctags
set nu                              " enable left numbers
set rnu
set fillchars=vert:\                " disable vert div chars
set cursorline                      " highlight the cursor screen line "
set cursorcolumn                    " highlight the cursor screen line "
set scrolloff=10                    " minimal number of screen lines to keep above and below the cursor "
set spell spelllang=en_us           " spellchecker
set lazyredraw                      " lazyredraw

" define a path to store persistent undo files.
let target_path = expand('~/.vim/persisted-undo/')
" create the directory and any parent directories
" if the location does not exist.
if !isdirectory(target_path)
  call system('mkdir -p ' . target_path)
endif
" point Vim to the defined undo directory.
let &undodir = target_path
" finally, enable undo persistence.
set undofile

" Auto indentation
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

let g:ruby_indent_access_modifier_style="indent"
let g:ruby_indent_assignment_style="variable"

" String to put at the start of lines that have been wrapped "
let &showbreak='↪ '


" jump to end of text you pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" remap colon
map ; :

" leader
let mapleader=","

"---------------- Plugins -------------------
call plug#begin('~/.vim/plugged')
  " Navigation
  Plug 'chaoren/vim-wordmotion'
  Plug 'easymotion/vim-easymotion'
  Plug 'scrooloose/nerdtree'
  Plug 'majutsushi/tagbar'
  Plug 'matze/vim-move'

  " config
  Plug 'editorconfig/editorconfig-vim'

  " Correction
  Plug 'dense-analysis/ale'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'reedes/vim-wordy'
  Plug 'github/copilot.vim', { 'branch': 'release' }
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'jphustman/sqlutilities'

  " Appearance
  Plug 'ryanoasis/vim-devicons'
  Plug 'tomasr/molokai'
  Plug 'fmoralesc/molokayo'
  Plug 'airblade/vim-gitgutter'
  Plug 'kshenoy/vim-signature'
  Plug 'Bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ap/vim-css-color'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'skywind3000/asyncrun.vim'

  " General editing
  Plug 'sbdchd/neoformat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tomtom/tcomment_vim'

  " Ruby/Rails
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-rails'
  Plug 'AndrewRadev/switch.vim'
  Plug 'vim-test/vim-test'
  Plug 'preservim/vimux'
  Plug 'victorfeijo/binding-pry-vim'

  " Languages
  Plug 'vim-ruby/vim-ruby'
  Plug 'noprompt/vim-yardoc'
  Plug 'zaiste/tmux.vim'
  Plug 'elzr/vim-json'
  Plug 'TAKAyukiatkwsk/vim-mongoid-syntax'
  " HTML
  Plug 'godlygeek/tabular'
  Plug 'preservim/vim-markdown'
  " for yaml syntax
  Plug 'towolf/vim-helm'
call plug#end()
"-------------- Plugins Settings--------------

" Required for operations modifying multiple buffers like rename.
set hidden

" copilot
imap <C-L> <Plug>(copilot-accept-word)

imap jj <Esc>

" easymotion
let g:EasyMotion_smartcase = 1
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" set airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'
set laststatus=2

" nerd tree
map <C-n> :NERDTreeToggle<CR>

" molokai & colors/italic/background
colo molokai
hi Normal ctermfg=252 ctermbg=none
hi Comment cterm=italic

" rspec
let test#strategy = {
  \ 'file': 'vimux',
\}

" run for current file test in new tmux window
map <Leader>t :TestFile<CR>

" nerd tree -> open current file in the file tree
map ff :NERDTreeFind<CR>

" rails
" open test file in vertical window
map <Leader>.h :AV<CR>
" go to test file builder.rb => builder_spec.rb
map <Leader>ra :A<CR>

" fzf
map <Leader>g :Rg<Cr>
" search by files
map <Leader>c :Files<Cr>

" ctags
nmap <C-t> :TagbarToggle<CR>

" move
let g:move_key_modifier = 'C'

" copy file path to system clipboard
nnoremap <Leader>fp :let @+ = expand('%')<CR>     " relative path
nnoremap <Leader>fP :let @+ = expand('%:p')<CR>   " absolute path

" fugitive
map <Leader>.s :Git<CR>
map <Leader>.b :Git blame<CR>
map <Leader>.w :GBrowse<CR>
map <Leader>.d :Gdiffsplit<CR>
set diffopt+=vertical

" ale
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'ruby': ['ruby', 'rubocop', 'reek']
\}

let g:airline#extensions#ale#enabled = 1

let g:ale_lint_on_text_changed = 1
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = '☠ '
let g:ale_echo_msg_warning_str = '♿'
let g:ale_sign_error = '☠ '
let g:ale_sign_warning = '♿'
let g:ale_echo_msg_format = '[%linter%] %s'
"---------------------- End -----------------------------

highlight clear SpellBad
highlight SpellBad cterm=bold,italic ctermfg=014 ctermbg=000

" wordy
let g:wordy#ring = [
  \ 'weak',
  \ ['being', 'passive-voice', ],
  \ 'business-jargon',
  \ 'weasel',
  \ 'puffery',
  \ ['problematic', 'redundant', ],
  \ ['colloquial', 'idiomatic', 'similies', ],
  \ 'art-jargon',
  \ ['contractions', 'opinion', 'vague-time', 'said-synonyms', ],
  \ 'adjectives',
  \ 'adverbs',
  \ ]


inoremap _ <C-]>_
inoremap . <C-]>.
inoremap - <C-]>-

filetype plugin indent on
