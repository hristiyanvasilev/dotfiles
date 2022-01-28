" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar', { 'do': ':UpdateRemotePlugins' }
Plug 'vimwiki/vimwiki', { 'do': ':UpdateRemotePlugins' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'drewtempelmeyer/palenight.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
Plug 'dhruvasagar/vim-table-mode'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'fatih/vim-go'

"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'


" Initialize plugin system
call plug#end()

set pumheight=10
set completeopt=menu,longest
let g:SuperTabDefaultCompletionType='context'
"hris - test
"let g:clang_complete_auto=1
"let g:clang_auto_select=2    " automatically select and insert the first matc

set clipboard=unnamed

" forces vim to source .vimrc file if it present in working directory, thus providing a place to 
" store project-specific configuration
set exrc
set secure

" enable syntax enable
syntax on

" set paste toggle to F2
set pastetoggle=<F2>

" 80 character line restriction
" column width to 80 characters
"set textwidth=80
"set colorcolumn=+1

if exists('+termguicolors')
  set termguicolors
endif
"
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set t_Co=256
set background=light
"set background=dark


"colorscheme palenight
colorscheme PaperColor

"let g:airline_theme = "papercolor"

" disale arrow keys to break bad habbits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" custom bindings
nnoremap <F10> :E<CR>
nnoremap <F5> :make<CR>
nnoremap <F4> :buffers<CR>:buffer<Space>
nnoremap <F3> :!<CR>

" fzf vim bindings
nnoremap ,t :Tags<CR>
nnoremap ,f :Files<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,l :Lines<CR>
nnoremap ,m :Map<CR>
nnoremap ,s :Snippets<CR>
nnoremap ,h :Helptags<CR>

nnoremap <Space><Space> :belowright split \| resize 10 \|exec 'term ++curwin ++close' \| startinsert<CR>

" use Esc exit terminal mode to normal mode
tnoremap <Esc> <C-\><C-n>

filetype plugin indent on

" associate .asm files with nasm
autocmd BufRead,BufNewFile *.asm set filetype=nasm

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set autoindent
" stricter rules for c indentation
set cindent

" enable ruler
set ruler

" highlight search
set hlsearch

" increment search
set incsearch

" set the fold method to indent and manual
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
augroup END 

" unfold everything
set foldlevel=999

" set line numbering on
"set relativenumber
set number

" enable airline all the time
set laststatus=2

" tagbar config
nmap <F8> :TagbarToggle<CR>

" vimwiki
set nocompatible
let g:vimwiki_list = [{'path': '$HOME/wiki'}]

" move swapfiles
set noswapfile

" +-------------------+
" |netrw configuration|
" +-------------------+

" dislay additional information about the files
let g:netrw_liststyle = 1

" disable banner
let g:netrw_banner = 0

" reuse the same window
let g:netrw_browse_split = 0

" when opened, what percentage of the screen should take
let g:netrw_winsize = 20

" don't keep history of directories that have been modified
let g:netrw_dirhistmax = 0

" check if should be removed
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

nnoremap <silent> <space>f  :<C-u>CocList files<cr>
nnoremap <silent> <space>g  :<C-u>CocList grep<cr>

" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" keymap for bulgarian-phonetic and default (us-english)
nnoremap <leader>lbg :set keymap=bulgarian-phonetic<CR>
nnoremap <leader>lus :set keymap=""<CR>

let g:coc_disable_startup_warning = 1
