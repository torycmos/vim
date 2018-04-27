set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/,~/.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'terryma/vim-multiple-cursors'                   " multiple cursors like sublime
Plugin 'tpope/vim-fugitive'                             " cool git wrapper
Plugin 'tpope/vim-commentary'                           " comment line/selection/etc
Plugin 'tpope/vim-surround'                             " comment line/selection/etc
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-dispatch'
Plugin 'altercation/vim-colors-solarized'               " solarized color scheme
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/powerline'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/Gundo'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'mtth/scratch.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'pearofducks/ansible-vim'
Plugin 'chrisbra/vim-diff-enhanced'                     " tries to find better diffs - run ':EnhancedDiff histogram'
Plugin 'gcmt/taboo.vim'					                        " stuff for tab names
Plugin 'Houl/repmo-vim'                                 " repeat various motions
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'                              " :mksession wrapper

" completions + such
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'Shougo/neocomplete.vim'
Plugin 'klen/python-mode'
Plugin 'fsharp/vim-fsharp'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'wlangstroth/vim-racket'
Plugin 'robbles/logstash.vim'
Plugin 'PProvost/vim-ps1'

" Plugin 'vim-scripts/YankRing.vim'  - plugin to break all your stuff
" Plugin 'Valloric/YouCompleteMe' - aka huge fuckin pain

call vundle#end()
filetype plugin indent on
syntax on


"""""""""""""""""""""" Powerline """"""""""""""""""""""""
let g:Powerline_symbols="fancy"
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

""""""""""""""""""""""  Appearance settings """""""""""""""""""""
highlight LineNr term=bold cterm=NONE ctermfg=10 ctermbg=0 gui=NONE guifg=DarkGrey guibg=#073642
highlight CursorLineNr guifg=#268bd2 ctermfg=4

if has('gui_running')
    set columns=210
    set lines=62
" makes terminal vim not have weird light background shade
else
    set term=xterm-256color
endif

set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 10
set laststatus=2
colorscheme solarized
set background=dark

""""""""""""""""""""""  general env settings """""""""""""""""""""
set autoread                        " reread file if other program changes it
set mouse=a                         " use mouse in terminal; hold shift to use default e.g. shift-rclick to paste
set hidden                          " allow switching buffer without saving it
set ignorecase                      " unless /c is used
set smartcase                       " /the finds The, the, etc; /The only finds The
set gdefault                        " subs use /g unless you put your own g to disable
set numberwidth=3                   " size of linenum column
set relativenumber
set cmdheight=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set scrolloff=3                     " start scrolling window before cursor is at top/bot
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,nbsp:␣
let &showbreak = '> '
set cpo+=n                          " use numbers column for wrapping lines
set wrap
set textwidth=99
set formatoptions=qrn1
set colorcolumn=105
set incsearch                       " show search matches while typing; <c-g> and <c-t> go to next/prev current match
set showmatch
set hlsearch                        " highlight all search matches of previous search
set number
set autoindent
set showmode
set showcmd
set wildmenu
set wildmode=list:longest,full      " show list of matches and complete first full match, then rest in order
set visualbell                      " flash screen for bell
set cursorline                      " highlight line cursor is on
set ttyfast
set ruler                           " show line-num : column-num in status bar
set undofile
set backspace=indent,eol,start      " backspace behaves like most other programs
set virtualedit=block               " draw an arbitrary block, not limited by line ending
set encoding=utf-8
set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/viminfo
set guioptions-=e                  " use term-style tabs
set guioptions-=T                  " don't show toolbar

let NERDTreeBookmarksFile=~/.vim/NERDTreeBookmarks
let mapleader=","

" change leader and remap backwards-char-search (,) to old leader (\)
" (doesn't really work well this way, just makes \ also mapleader)
noremap \ ,

" return to previous edit position when opening buffers
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"""""""""""""""""""""  normal mode remaps """""""""""""""""""""
" make k and j move to same visual column position even if in long wrapped line
nnoremap k gk
nnoremap j gj

" disable visual mode Q shortcut
nnoremap Q <nop>

" toggle paste mode
nnoremap <leader>pp :setlocal paste!<cr>

" tab goes to corresponding open/close ({[]}) /* */ etc, can be modified with 'matchpairs' opt
nnoremap <tab> %

" ,l to show invis chars
nmap <leader>l :set list! showbreak!<CR>
" ,R to color parens
nmap <leader>R :RainbowParenthesesToggle

" move between windows with ctrl-hjkl
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

",v to split into a new window vertically
nnoremap <leader>v <C-w>v<C-w>l
",s to split horizontally
nnoremap <leader>s <C-w>s<C-w>j

" manage tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove

"open tab with current buffer's cwd
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" switch editor cwd to that of current buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" ctrl + arrow to move view between tabs; alt + arrow to move tab in tablist
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" ctrl + shift + [ ] also to change tab view
nmap <C-S-]> gt
nmap <C-S-[> gT

" ctrl + n to move to nth tab
nmap <C-1> 1gt
nmap <C-2> 2gt
nmap <C-3> 3gt
nmap <C-4> 4gt
nmap <C-5> 5gt
nmap <C-6> 6gt
nmap <C-7> 7gt
nmap <C-8> 8gt
nmap <C-9> 9gt
nmap <C-0> :tablast<CR>

" from bclose.vim; kill buffer without losing window setup (if it works)
nmap <leader>bd <Plug>Kwbd

" repmo-vim - repeat various motions with ; (forwards) and backspace (backwards)
map <expr> ; repmo#LastKey(';')|sunmap ;
map <expr> <BS> repmo#LastRevKey('')|sunmap <BS>

noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l
map <expr> j repmo#Key('gj', 'gk')|sunmap j
map <expr> k repmo#Key('gk', 'gj')|sunmap k

noremap <expr> f repmo#ZapKey('f')|sunmap f
noremap <expr> F repmo#ZapKey('F')|sunmap F
noremap <expr> t repmo#ZapKey('t')|sunmap t
noremap <expr> T repmo#ZapKey('T')|sunmap T

"""""""""""""""""""""  visual mode remaps """""""""""""""""""""

" tab to switch ends of visual mode selection
vnoremap <tab> %

vnoremap . :normal .<CR>

vnoremap < <gv
vnoremap > >gv

" // to search whatever is selected in visual mode
vnoremap // y/<C-R>"<CR>

" visual-mode jp yanks to OS clipboard
vnoremap jp "+y

" ,<space> to clear search highlights
nnoremap <leader><space> :noh<cr>

"""""""""""""""""""""  insert mode remaps """""""""""""""""""""
inoremap jk <ESC>

" jp puts '+' buffer i.e. OS clipboard
inoremap jp <c-r>+

"save whenever you switch wandows
au FocusLost * :wa
au VimEnter * RainbowParenthesesToggle



""""""""""""""""""""" Undo / Swap / Backup """""""""""""""""""""
" vim wont make directories so make em if they aint there; 
" these make the ~/.vim/blah directories and set the option 
" to use em

if isdirectory($HOME . '/.vim/backup') == 0
      :silent !mkdir -p ~/.vim/backup &>/dev/null
endif
set backupdir-=.                        " this stuff removes currentdir from list and appends it
set backupdir+=.                        " then removes ~ and prepends ~/.vim/backup
set backupdir-=~/
set backupdir^=~/.vim/backup//
set backupdir^=./.vim-backup//
set backup

" put the undo files in ~/.vim/undo unless .vim-undo exists
" vim will never delete undo files so you gotta do that yourself
"
" If you write to a file with some other program and then open it with vim
" the hash wont match and it won't open the undo
if isdirectory($HOME . '/.vim/undo') == 0
      :silent !mkdir -p ~/.vim/undo >/dev/null 2>&1
endif
set undodir=./.vim-undo//
set undodir+=~/.vim/undo//
set undofile

if isdirectory($HOME . '/.vim/swap') == 0
      :silent !mkdir -p ~/.vim/swap &>/dev/null
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

nnoremap <F9> :GundoToggle<CR>

" syntastic stuff
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ultisnips stuff
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"


"python mode stuff
let g:pymode_rope_complete_on_dot = 0   " keeps it from freezing for a while when you use '.'

" reload vimrc when you write it
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
