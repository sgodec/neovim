let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable
set background=dark
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent
set cursorline
set incsearch
set hlsearch
set clipboard=unnamedplus
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

call plug#begin('~/.config/nvim/plugged')


" Add plugins below this line
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'davidhalter/jedi-vim'
Plug 'preservim/nerdtree'
Plug 'ycm-core/YouCompleteMe'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-surround' 
Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/indentLine'
Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'
Plug 'vim-python/python-syntax'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-dispatch'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Add plugins above this line
call plug#end()
" make it nicer "
set number
set relativenumber
set noshowmode
set noruler
set linespace=3
set laststatus=2
set termguicolors
colorscheme nord

let g:ale_linters = {
\ 'cpp': ['clangd', 'cppcheck'],
\ 'python': ['flake8'],
\}

let g:ale_fixers = {
\ 'cpp': ['clang-format'],
\ 'python': ['black'],
\}
let g:ale_fix_on_save = 1


hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE 
highlight LineNr guifg=#d3d3d3
highlight CursorLineNr guifg=#00ffff


let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
\ 'build_dir' : '',
\ 'callback' : 1,
\ 'continuous' : 1,
\ 'executable' : 'latexmk',
\ 'options' : [
\   '-lualatex',
\   '-file-line-error',
\   '-synctex=1',
\   '-interaction=nonstopmode',
\ ],
\}

" Enable YCM
let g:ycm_enable = 1

" Use clangd as the completion engine
let g:ycm_clangd_binary_path = '/usr/bin/clangd'  " Adjust the path if necessary

" Set the completion trigger key to Tab
let g:ycm_key_list_select_completion = ['<Tab>']
let g:ycm_key_list_previous_completion = ['<Shift-Tab>']

" Enable automatic completion popup
let g:ycm_autoclose_preview_window_after_completion = 1
" Enables backup files.

" Automatically save the current file every 30 seconds
function! AutoSaveCurrentFile(timer_id)
    if &modified
        write
    endif
endfunction

" Start a timer that triggers AutoSaveCurrentFile every 30000ms (30 seconds)
let s:autosave_timer = timer_start(30000, 'AutoSaveCurrentFile', {'repeat': -1})
nnoremap <F5> :Dispatch python3 %<CR>
nnoremap <F5> :w <bar> !g++ -std=c++17 % -o %:r && tmux split-window -h 'sh -c "./%:r; echo Press ENTER to continue; read line'"<CR>

" open NERDTree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080"   
    "\ }                         


let g:NERDTreeIgnore = ['^node_modules$']

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

nmap <leader>do <Plug>(coc-codeaction)

nmap <leader>rn <Plug>(coc-rename)

let g:coc_global_extensions = [
\ 'coc-python',
\ 'coc-clangd'
\ ]

nnoremap <C-S> :wqa!<CR>
nnoremap <C-X> :w!<CR>
nnoremap <C-Q> :q!<CR>
inoremap <C-X> <Esc>
vnoremap <C-X> <Esc>
nnoremap <C-Y> :%y+<CR>

