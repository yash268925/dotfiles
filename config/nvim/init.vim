set smartcase
set smartindent
set number
set modeline
set autoread
set fileencodings=utf-8,iso-2022-jp-3,cp932,sjis,euc-jp,ucs-bom,guess,latin1
set fileencoding=utf-8
set laststatus=2
set ignorecase
set hlsearch
set list
set listchars=eol:$,tab:>-,space:.
set wildignorecase
set number relativenumber

" project default setting
" overwrite with .vimrc.local in some Projects
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

syntax on

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sN gt
nnoremap sP gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap sn :<C-u>bn<CR>
nnoremap sp :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap t; t
nnoremap t <Nop>
nnoremap to :<C-u>edit<Space>
nnoremap tt :<C-u>tabnew<Space>
nnoremap <expr> tO ':<C-u>edit ' . GetRelativePath()
nnoremap <expr> tT ':<C-u>tabnew ' . GetRelativePath()
nnoremap ts :<C-u>split<Space>
nnoremap <expr> tS ':<C-u>split ' . GetRelativePath()
nnoremap tv :<C-u>vsplit<Space>
nnoremap <expr> tV ':<C-u>vsplit ' . GetRelativePath()
nnoremap <silent> td :<C-u>tabclose<CR>

" copy to system clipboard
nnoremap <Space>y "+yy
vnoremap <Space>y "+yy
nnoremap <Space>p "+p
vnoremap <Space>p "+p

" escape from terminal mode
tnoremap <C-w>n <C-\><C-n>

" re-syntax
nnoremap <C-s> <Esc>:syntax sync fromstart<CR>

" load global plugins
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'itchyny/lightline.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'kassio/neoterm'

Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'cocopon/iceberg.vim'
Plug 'cocopon/vaffle.vim'
Plug 'taohexxx/lightline-buffer'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'rhysd/conflict-marker.vim'

Plug 'tpope/vim-fugitive'
Plug 'cohama/agit.vim'
Plug 'rhysd/committia.vim'

Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'do': 'yarn install' }

Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'jeroenbourgois/vim-actionscript'
Plug 'leafgarland/typescript-vim'
Plug 'cespare/mxml.vim'
Plug 'rust-lang/rust.vim'

call plug#end()

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" apply mxml syntax
autocmd BufRead *.mxml set filetype=mxml

" load project local vimrc
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" use iceberg colorscheme
set termguicolors
set cursorline

colorscheme iceberg

" use iceberg colorscheme with lightline
" use FugitiveHead with lightline
let g:lightline = {
  \ 'colorscheme': 'iceberg',
  \ 'tabline': {
  \   'left': [ [ 'bufferinfo' ],
  \             [ 'separator' ],
  \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
  \   'right': [ [ 'close' ], ],
  \ },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'bufferinfo': 'lightline#buffer#bufferinfo',
  \ },
  \ 'component_expand': {
  \   'buffercurrent': 'lightline#buffer#buffercurrent',
  \   'bufferbefore': 'lightline#buffer#bufferbefore',
  \   'bufferafter': 'lightline#buffer#bufferafter',
  \ },
  \ 'component_type': {
  \   'buffercurrent': 'tabsel',
  \   'bufferbefore': 'raw',
  \   'bufferafter': 'raw',
  \ },
  \ 'component': {
  \   'separator': '',
  \ },
  \ }

" make popup to transparent
set pumblend=20
set winblend=20

" git editor config
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif


" === conflict-marker settings ===
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
" ==========


" === coc settings ===
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Add `:Format` command to format current buffer.
command! -nargs=0 Fix :CocCommand eslint.executeAutofix
" ==========

" === Agit keymaps ===
autocmd FileType agit call s:agit_keymaps()

function! s:agit_keymaps()
  nmap <buffer> R <Plug>(agit-reload)
endfunction
" ==========

" === neoterm settings ===
let g:neoterm_autoscroll=1
let g:neoterm_size=20
let g:neoterm_fixedsize=1
let g:neoterm_default_mod='bo'
" ==========

" === Sayonara ===
nnoremap sq :<C-u>Sayonara<CR>
nnoremap sQ :<C-u>Sayonara!<CR>

let g:sayonara_confirm_quit=1
" ==========

" === lightline-buffer settings ===
set hidden
set showtabline=2
" ==========

" === vaffle ===
command! -nargs=0 Vc :call vaffle#init(expand('%:p:h'))
" ==========
