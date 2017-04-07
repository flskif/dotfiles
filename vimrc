set nowrap
set textwidth=80
set expandtab
set shiftwidth=2
set noswapfile
map <space> <leader>
nmap <leader>w :w<CR>
nmap <silent><leader>q :q<CR>
autocmd BufReadPost quickfix nmap <buffer> q :q<CR>
nnoremap Y y$
cnoremap <expr> %% expand('%:h').'/'

" allow unsaved changes
set hidden

" read custom configurations in .vimrc per folder
set exrc
set secure

set fillchars=fold:—,vert:\│

" config for messages appearing at the bottom
set shortmess=
set shortmess+=a " use abbreviations
set shortmess+=T " truncate long messages
set shortmess+=W " don't show 'written' message

call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'w0ng/vim-hybrid'
let g:hybrid_custom_term_colors=1
let g:hybrid_reduced_contrast=1
set background=dark
" Make statusline a bit easier on the eyes
highlight StatusLine cterm=bold ctermfg=15 ctermbg=8 gui=bold

if has('nvim')
  " Use <C-L> to clear the highlighting of :set hlsearch.
  if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
  endif

  " Esc to go back from terminal mode
  tnoremap <Esc> <C-\><C-n>
else
  Plug 'tpope/vim-sensible'
endif

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

" Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
let g:ctrlp_working_path_mode=0
let g:ctrlp_extensions=['buffertag']
nmap <silent><leader>o :CtrlP<CR>
" nmap <silent><leader>T :CtrlPBufTag<CR>
nmap <silent><leader>b :CtrlPBuffer<CR>

" Don't quit the window when killing buffer
Plug 'qpkorr/vim-bufkill'
let g:BufKillCreateMappings=0
nmap <leader>d :BD<CR>
nmap <leader>D :bufdo BD<CR>

" Search
Plug 'mileszs/ack.vim', {'on': 'Ack'}
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
map <leader>f :Ack<space>
map <leader>F :Ack<cword><CR> " search word under cursor

" Git
Plug 'tpope/vim-fugitive'
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>gc :Gcommit --verbose<CR>

" Gists
Plug 'mattn/webapi-vim', {'on': 'Gist'}
Plug 'mattn/gist-vim', {'on': 'Gist'}
let g:gist_show_privates = 1
let g:gist_post_private = 1
let g:gist_clip_command = 'pbcopy'

" Neomake
if has('nvim')
  Plug 'neomake/neomake'
  nmap <silent><leader>m :update\|Neomake<CR>
  nmap <silent><leader>M :update\|Neomake!<CR>
endif

" Autocompletion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
  let g:deoplete#enable_at_startup = 1
endif

" Autoformat
Plug 'sbdchd/neoformat'
let g:neoformat_only_msg_on_error = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_basic_format_retab = 1
nmap <leader>a :Neoformat<CR>

" Elm
Plug 'elmcast/elm-vim', {'for': 'elm'}
let g:elm_make_show_warnings = 1
let g:elm_classic_highlighting = 1
let g:elm_setup_keybindings = 0
au FileType elm setlocal softtabstop=4 shiftwidth=4
au FileType elm nmap <buffer><leader>t :update\|!clear&elm test<CR>
au FileType elm nmap <buffer><leader>m :update\|ElmMakeMain<CR>
au FileType elm nmap <buffer><leader>e :ElmErrorDetail<CR>
au BufWritePost *.elm Neomake

" Haskell
if has('nvim')
  Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
  Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
  let g:neomake_haskell_enabled_makers = ['hdevtools']
  let g:neoformat_enabled_haskell = ['hindent']
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
endif
Plug 'pbrisbin/vim-syntax-shakespeare', {'for': ['haskell', 'hamlet', 'cassius', 'lucius', 'julius']}
Plug 'Twinside/vim-hoogle', {'for': 'haskell'}
let g:hoogle_search_count=20
let g:hoogle_search_buf_size=20

" Pug
Plug 'digitaltoad/vim-pug', {'for': 'pug'}

" Javascript (ES6)
Plug 'othree/yajs.vim', { 'for': 'javascript' }

call plug#end()

" Must go after plug#end()
colorscheme hybrid
highlight SignColumn ctermbg=NONE
highlight NeomakeErrorSignDefault ctermbg=NONE
highlight NeomakeWarningSignDefault ctermbg=NONE
highlight NeomakeMessageSignDefault ctermbg=NONE
highlight NeomakeInfoSignDefault ctermbg=NONE
