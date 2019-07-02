set nowrap
set textwidth=80
set number
set expandtab
set shiftwidth=2
set noswapfile
map <space> <leader>
nmap <leader>w :w<CR>
nmap <silent><leader>q :q<CR>
nnoremap Y y$
cnoremap <expr> %% expand('%:h').'/'

augroup quickfix
  autocmd!
  autocmd BufReadPost quickfix nmap <buffer> q :q<CR>
augroup END

" open help in right split
cnoreabbrev h vert bo h

" smart case search
set ignorecase
set smartcase

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

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Live substitution preview
set inccommand=split

" Esc to go back from terminal mode
tnoremap <Esc> <C-\><C-n>
" C-^ to go to alternate file from terminal mode
tnoremap <C-^> <C-\><C-n>:e #<CR>

" Prefer terminal insert mode to normal mode.
augroup terminal
  autocmd!
  autocmd BufEnter term://* startinsert
  autocmd BufEnter term://* setlocal nonumber
  autocmd BufLeave term://* stopinsert
augroup END

augroup vim
  autocmd!
  " auto reload vimrc
  autocmd BufWritePost vimrc,.vimrc,init.vim source $MYVIMRC
  " K opens help
  autocmd FileType vim set keywordprg=:vert\ bo\ h
augroup END

call plug#begin('~/.vim/plugged')

" Netrw
Plug 'tpope/vim-vinegar'
let g:netrw_preview=1 " vertical split for preview using 'p' command

" seamless tmux pane navigation
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_disable_when_zoomed = 1
nnoremap <silent> <C-Left> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-Right> :TmuxNavigateRight<CR>
nnoremap <silent> <C-Down> :TmuxNavigateDown<CR>
nnoremap <silent> <C-Up> :TmuxNavigateUp<CR>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<CR>
tnoremap <silent> <C-Left> <C-\><C-n>:TmuxNavigateLeft<CR>
tnoremap <silent> <C-Right> <C-\><C-n>:TmuxNavigateRight<CR>
tnoremap <silent> <C-Down> <C-\><C-n>:TmuxNavigateDown<CR>
tnoremap <silent> <C-Up> <C-\><C-n>:TmuxNavigateUp<CR>
tnoremap <silent> <C-\> <C-\><C-n>:TmuxNavigatePrevious<CR>

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 400

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

" Fuzzy file finder
" Help: Toggle + down <Tab>, Toggle + up <S-Tab>
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_COMMAND='ag -g ""'
let $FZF_DEFAULT_OPTS='--color=bg+:-1 --inline-info'
let g:fzf_layout = { 'down': '10' }
let g:fzf_buffers_jump = 0
augroup fzf
autocmd! FileType fzf
  " close on Esc
  autocmd FileType fzf tnoremap <Esc> <C-c>
  " hide status line
  autocmd FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
nmap <silent><leader>o :Files<CR>
nmap <silent><leader>b :Buffers<CR>

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
nmap <leader>gb :Gblame<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>gc :Gcommit --verbose<CR>
nmap <leader>gr :Gread<CR>

" Github
Plug 'tpope/vim-rhubarb'

" Gists
Plug 'mattn/webapi-vim', {'on': 'Gist'}
Plug 'mattn/gist-vim', {'on': 'Gist'}
let g:gist_show_privates = 1
let g:gist_post_private = 1
let g:gist_clip_command = 'pbcopy'

" Neomake
Plug 'neomake/neomake', {'on': 'Neomake' }
nmap <silent><leader>m :update\|Neomake<CR>
nmap <silent><leader>M :update\|Neomake!<CR>

" Snippets
Plug 'SirVer/ultisnips'

" Autoformat
Plug 'sbdchd/neoformat'
let g:neoformat_only_msg_on_error = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_try_formatprg = 1
nmap <leader>a :Neoformat<CR>

" Text
augroup text
  autocmd!
  autocmd FileType text,markdown setlocal wrap linebreak
  autocmd FileType gitcommit,markdown setlocal spell
augroup END

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Fish
Plug 'vim-scripts/fish-syntax', {'for': 'fish'}

" Conquer of Completion (currently Elm only)
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': 'elm'}
set updatetime=300 " CursorHold timeout, affects diagnostics messages float window
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> K :call CocAction('doHover')<CR>
command! -nargs=0 Rename :call CocAction('rename')
hi! link CocCodeLens NonText

" Elm
Plug 'andys8/vim-elm-syntax', {'for': 'elm'}
augroup elm
  autocmd!
  autocmd BufWritePost *.elm :call CocAction('format')
  autocmd FileType elm setlocal comments=:--
  autocmd FileType elm setlocal commentstring=--\ %s
augroup END

" Haskell
let g:neomake_haskell_enabled_makers = ['hlint']
Plug 'pbrisbin/vim-syntax-shakespeare', {'for': ['haskell', 'hamlet', 'cassius', 'lucius', 'julius']}
Plug 'parsonsmatt/intero-neovim', {'for': 'haskell'}
augroup haskell
  autocmd!
  autocmd FileType haskell setlocal formatprg=brittany

  autocmd BufWritePost *.hs Neomake
  autocmd BufWritePost *.hs InteroReload

  " intero buffer
  autocmd BufEnter Intero setlocal nonumber
  autocmd BufEnter Intero nmap <buffer>q :InteroHide<CR>
  autocmd BufEnter Intero startinsert
  autocmd BufLeave Intero stopinsert

  " intero mappings
  autocmd FileType haskell nnoremap <leader>in :b Intero<CR>
  autocmd FileType haskell nnoremap <leader>iv :vert sb Intero<CR><ESC><C-W><C-\>
  autocmd FileType haskell nnoremap <leader>is :InteroOpen<CR>
  autocmd FileType haskell nnoremap <leader>ih :InteroHide<CR>
  autocmd FileType haskell nnoremap <leader>il :InteroLoadCurrentFile<CR>
  autocmd FileType haskell nnoremap <leader>ir :InteroRestart<CR>
  autocmd FileType haskell nnoremap <leader>it :InteroTypeInsert<CR>
  autocmd FileType haskell nnoremap <leader>id :execute("InteroEval :doc " . expand('<cword>'))<CR>
  autocmd FileType haskell map <buffer>K <Plug>InteroGenericType
  autocmd FileType haskell nnoremap <silent><buffer><C-]> :InteroGoToDef<CR>
augroup END

" Pug
Plug 'digitaltoad/vim-pug', {'for': 'pug'}
augroup pug
  autocmd!
  autocmd FileType pug setlocal softtabstop=2 shiftwidth=2
  autocmd FileType pug setlocal formatprg=pug-beautifier\ --fillspace\ 2\ --omitdiv
augroup END

" Javascript (ES6)
Plug 'othree/yajs.vim', { 'for': 'javascript' }
augroup js
  autocmd!
  autocmd FileType javascript setlocal softtabstop=2 shiftwidth=2
  autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --stdin-filepath=%:p
  autocmd BufWritePost *.js Neomake
augroup END

" HTML
augroup html
  autocmd!
  autocmd FileType html,xhtml setlocal softtabstop=2 shiftwidth=2
  autocmd FileType html,xhtml setlocal formatprg=html-beautify\ --type\ html\ --indent-size\ 2\ --end-with-newline\ --indent-inner-html\ --max-preserve-newlines\ 2\ --wrap-line-length\ 80
augroup END

" Rust
augroup rust
  autocmd!
  autocmd BufWritePost *.rs Neoformat
  autocmd BufWritePost *.rs Neomake
augroup END

" Purescript
Plug 'purescript-contrib/purescript-vim', {'for': 'purescript'}
augroup purescript
  autocmd!
  autocmd BufWritePost *.purs Neoformat
  autocmd BufWritePost *.purs Neomake
augroup END

" Ruby
let g:neomake_ruby_reek_remove_invalid_entries=1
let g:neomake_ruby_flog_remove_invalid_entries=1
Plug 'tpope/vim-rake', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-bundler', {'for': 'ruby'}

" TypeScript
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
let g:typescript_indent_disable = 1

" Colorscheme
Plug 'flskif/terminal16.vim'

call plug#end()

" Must go after plug#end()
colorscheme terminal16
hi! HighlightedyankRegion ctermbg=yellow ctermfg=black
