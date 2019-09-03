execute pathogen#infect()

syntax on
set ruler
set number
set mouse=nv

" Set up vim clipboard and system clipboard to sync
set clipboard=unnamed

" Set up tab sizing
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" Make line cursor on be highlighted
set cursorline

" Set the <Leader> key to `,`
let mapleader = ","

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

" Map Cmd + jklh to change windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Map <leader> (currently ,) + jklh to move windows
nnoremap <leader>j <C-W>J
nnoremap <leader>k <C-W>K
nnoremap <leader>l <C-W>L
nnoremap <leader>h <C-W>H

" Set up pane splitting to "feel" more natural
set splitbelow
set splitright

" Map Ctrl+N to opening / closing the file explorer
map <C-n> :NERDTreeToggle<CR>
" let NERDTreeQuitOnOpen = 1    " Close nerdtree on open
let NERDTreeShowHidden=1      " Show hidden files
let NERDTreeMinimalUI=1       " Disables the "Press ? for help" dialog at the top of NERDTree

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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End config settings for automatic undo / backup settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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

" vim-javascript settings
let g:javascript_plugin_jsdoc = 1  " Enable syntax highlighting for JSDoc comments
" Proper JS Folding with vim-javascript
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
set foldlevelstart=99 "start file with all folds opened

" Theme settings
let g:airline_theme='one'
set background=dark
let g:one_allow_italics=1 " Turn on italics
colorscheme one

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" vim-brittany setup
let g:brittany_on_save = 1

"""""""""""""""""""""
" Ctrl Space settings
"""""""""""""""""""""
set nocompatible
set hidden
set showtabline=0
let g:CtrlSpaceDefaultMappingKey = "<C-space> "
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1

" Enable deoplete on startup
" (python3 enabled JS autocompletion)
let g:deoplete#enable_at_startup = 1

" Set it up so that Prettier runs on save for .js .jsx and .ts files
autocmd BufWritePre,FileWritePre,FileAppendPre *.js :Prettier
autocmd BufWritePre,FileWritePre,FileAppendPre *.jsx :Prettier
autocmd BufWritePre,FileWritePre,FileAppendPre *.ts :Prettier

" NERDcommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'

" Set up autocomplete menu to resemble zsh
set wildmenu
set wildmode=full

" Make VIM remeber more previously ran commands
set history=1000

" Automatically remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Set the default vim search to be case insensitive
" You can add the \c to search using the correct case
" OR you if you use an uppercase letter will switch to
" case specific searching.
" https://stackoverflow.com/questions/2287440/how-to-do-case-insensitive-search-in-vim
set ignorecase
set smartcase
