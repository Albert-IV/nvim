execute pathogen#infect()

syntax on
set ruler
set number
set mouse=nv

" Set up tab sizing
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab 

" Make line cursor on be highlighted
set cursorline

" Set up buffers to be able to be hidden.
" Checking which buffers are open is as easy as:
" :ls which lists which buffers are currently loaded and
" :buffer <tab> | <number> | <filename> to open the buffer 
set hidden

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

" Map Ctrl+N to opening / closing the file explorer
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1    " Close nerdtree on open
let NERDTreeShowHidden=1      " Show hidden files
let NERDTreeMinimalUI=1       " Disables the "Press ? for help" dialog at the top of NERDTree

" Ensures VIM won't open files on the NERDTree window on accident
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" Ignore files from file search that are in the .gitignore file
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Ignore _ errors inside of markdown files.
" NOTE: does not work in the vimrc... :facepalm:
"" syn match markdownError "\w\@<=\w\@="

" Automatically use sudo if writing to a proteceted file (via suda)
let g:suda_smart_edit = 1

" Have undotree be shorter
"" let g:undotree_ShortIndicators = 1
let g:undotree_SplitWidth = 27 
let g:undotree_WindowLayout = 2 

" Binds F5 (will probably change this) to showing / hiding Undotree
nnoremap <F5> :UndotreeToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup config settings supplied by this nice article:
" https://begriffs.com/posts/2019-07-19-history-use-vim.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory^=~/.vim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has("patch-8.1.0251")
	" consolidate the writebackups -- not a big
	" deal either way, since they usually get deleted
	set backupdir^=~/.vim/backup//
end

" persist the undo tree for each file
set undofile
set undodir^=~/.vim/undo//
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Some defaults for running eslint for JS provided by:
" https://medium.com/@hpux/vim-and-eslint-16fa08cc580f
"" set statusline+=%#warningmsg#
"" set statusline+=%{SyntasticStatuslineFlag()}
"" set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'
