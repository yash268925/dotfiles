colorscheme wombat256

set smartcase
set smartindent
set number
set modeline
set foldcolumn=4
set autoread
set fileencodings=utf-8,iso-2022-jp-3,cp932,sjis,euc-jp,ucs-bom,guess,latin1
set fileencoding=utf-8
"set statusline=[%n]%F%m%r%h%w\ %{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y%=%{fugitive#statusline()}\(%1l/%L\)L,%cC%V%8P
set laststatus=2
set ignorecase
set hlsearch
set list
set listchars=eol:$,tab:>-,space:.
set wildignorecase

" project default setting
" (overwrite with .vimrc.local in some Projects)
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
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
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

"escape from terminal mode
tnoremap <C-w>n <C-\><C-n>

"change whitespace highlight color
highlight Whitespace ctermfg=240

" load global plugins
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
Plug 'cakebaker/scss-syntax.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

Plug 'Shougo/neosnippet.vim',
Plug 'Shougo/neosnippet-snippets'

Plug 'othree/html5.vim'
Plug 'jeroenbourgois/vim-actionscript'
Plug 'leafgarland/typescript-vim'
Plug 'cespare/mxml.vim'

call plug#end()

" use deoplete
let g:python3_host_prog='/usr/local/bin/python3.7'
let g:deoplete#enable_at_startup = 1

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
