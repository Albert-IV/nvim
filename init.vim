execute pathogen#infect()

syntax on
set ruler
set number

" Set up tab sizing
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab 

" Vim Clojure Static
filetype plugin indent on

" Autostart NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Map Cmd + JKLH to change panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set up pane splitting to "feel" more natural
set splitbelow
set splitright

" Close vim if only the file tree is displayed
"" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Map Ctrl+N to opening / closing the file explorer
map <C-n> :NERDTreeToggle<CR>

" Ignore files from file search that are in the .gitignore file
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Ignore _ errors inside of markdown files.
" NOTE: does not work in the vimrc... :facepalm:
"" syn match markdownError "\w\@<=\w\@="

" Automatically use sudo if writing to a proteceted file (via suda)
let g:suda_smart_edit = 1


