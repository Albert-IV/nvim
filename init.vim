" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" START PLUGINS
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
call plug#begin(stdpath('config') . '/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme(s) / Themes / Status Lines
""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'rbong/vim-crystalline'
Plug 'luochen1990/rainbow'

""""""""""""""""""""""""""""""""""""""""""""""""""
" General Utilities
""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'machakann/vim-sandwich'
Plug 'preservim/nerdtree'
Plug 'lambdalisue/suda.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-obsession'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mileszs/ack.vim'
Plug 'neovim/nvim-lsp'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Language Specific
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" General Languages
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'
" Plug 'nvim-treesitter/nvim-treesitter'

" Javascript
Plug 'prettier/vim-prettier'

" Clojure
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}

" CSS
Plug 'ap/vim-css-color'

" Wrap up so we can use the plugins later in our config
call plug#end()
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" END PLUGINS
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Theme settings
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colo gruvbox

" General settings
syntax on
set ruler
set number
set mouse=nv
set wrap

" Enable True Color in terminal
" https://github.com/neovim/neovim/wiki/FAQ#how-can-i-use-true-color-in-the-terminal
set termguicolors

" Set up vim clipboard and system clipboard to sync
set clipboard=unnamed

" Set up tab sizing
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
augroup ElmIndentation
  autocmd!
  autocmd FileType elm setlocal shiftwidth=4 tabstop=4 smarttab
augroup END

" Enable transparent tooltips
set pumblend=40

" Make line cursor on be highlighted
set cursorline

" Also cursor column highlight
set cursorcolumn

" Set the <Leader> key to `,`
let mapleader = ","

" Set up buffers to be able to be hidden.
" Checking which buffers are open is as easy as:
" :ls which lists which buffers are currently loaded and
" :buffer <tab> | <number> | <filename> to open the buffer
set hidden

" Set the default vim search to be case insensitive
" You can add the \c to search using the correct case
" OR you if you use an uppercase letter will switch to
" case specific searching.
" https://stackoverflow.com/questions/2287440/how-to-do-case-insensitive-search-in-vim
set ignorecase
set smartcase

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


inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set up autocomplete menu to resemble zsh
set wildmenu
set wildmode=full

" Make VIM remeber more previously ran commands
set history=1000

" Ensure when editing crontab entries you're able to save:
" https://superuser.com/a/907889/197740
augroup FixWritingCrons
  autocmd!
  autocmd filetype crontab setlocal nobackup nowritebackup
augroup END

" Show live substitutations when using :%s/pattern/replacement/
set inccommand=split

" If on nightly version of neovim, highlight yanked text
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""" BEGIN PLUGIN SETTINGS """"""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START NERDTree Specific Settings
""""""""""""""""""""""""""" 
" Autostart NERDTree
augroup NERDTreeAutostart
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
augroup END

" Map Ctrl+N to opening / closing the file explorer
map <C-n> :NERDTreeToggle<CR>

" Show hidden files
let NERDTreeShowHidden=1      

" Disables the "Press ? for help" dialog at the top of NERDTree
let NERDTreeMinimalUI=1       
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Nerdtree
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Suda Specific Settings
""""""""""""""""""""""""""" 
" Automatically use sudo if writing to a proteceted file (via suda)
let g:suda_smart_edit = 1
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Suda Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Undotree Specific Settings
""""""""""""""""""""""""""" 
" Have undotree be shorter
"" let g:undotree_ShortIndicators = 1
let g:undotree_SplitWidth = 27
let g:undotree_WindowLayout = 2

" Binds F5 (will probably change this) to showing / hiding Undotree
nnoremap <F5> :UndotreeToggle<cr>
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Undotree Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Prettier Specific Settings
""""""""""""""""""""""""""" 
" Set it up so that Prettier runs on save for .js .jsx and .ts files
augroup AutomaticPrettier
  autocmd!
  autocmd BufWritePre,FileWritePre,FileAppendPre *.js :Prettier
  autocmd BufWritePre,FileWritePre,FileAppendPre *.jsx :Prettier
  autocmd BufWritePre,FileWritePre,FileAppendPre *.ts :Prettier
augroup END
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Prettier Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START CtrlSpace Specific Settings
""""""""""""""""""""""""""" 
set nocompatible
set showtabline=0
let g:CtrlSpaceDefaultMappingKey = "<C-space> "
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END CtrlSpace Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Rainbow Specific Settings
""""""""""""""""""""""""""" 
let g:rainbow_active = 1
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Rainbow Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START FZF Specific Settings
""""""""""""""""""""""""""" 
" Shoutout to this nice blog post:
" https://www.erickpatrick.net/blog/adding-syntax-highlighting-to-fzf.vim-preview-window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
nnoremap <C-p> :<C-u>FZF<CR> 
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END FZF Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START ack Specific Settings
""""""""""""""""""""""""""" 
" Use ag if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap <Leader>f :Ack!<Space>""<Left>
nnoremap <Leader>F :Ack!<CR>
let g:ack_autoclose = 1
let g:ackhighlight = 1
let g:ackpreview = 1
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END ack Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START vim-lsp Specific Settings
""""""""""""""""""""""""""" 
" Sets up TS server LSP with default options
lua <<EOF
require'nvim_lsp'.tsserver.setup{}
EOF

" Set up Clojure LSP support
lua <<EOF
require'nvim_lsp'.clojure_lsp.setup{}
EOF

" View type information
nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>

" View where the function was defined
nnoremap <silent>gd    <cmd>lua vim.lsp.buf.definition()<CR>

" Always show the sign gutter, since LSP will add to it as you type
set signcolumn=yes

""" TODO: Verify this works how we want it to.
augroup ALEAutocompleteOFF 
  autocmd FileType javascript let g:ale_disable_lsp = 1
  autocmd FileType clojure let g:ale_disable_lsp = 1
augroup END
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END vim-lsp Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Deoplete Specific Settings
""""""""""""""""""""""""""" 
" Enable Deoplete
let g:deoplete#enable_at_startup = 1
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Deoplete Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Crystalline Specific Settings
""""""""""""""""""""""""""" 
" Default settings from README
function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f%h%w%m%r '

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! TabLine()
  let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'default'

set showtabline=2
set guioptions-=e
set laststatus=2
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Crystalline Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Treesitter Specific Settings
""""""""""""""""""""""""""" 
" Enable it all
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = { "javascript", "typescript", "go", "json" },
"   highlight = {
"     enable = true,
"   },
"   refactor = {
"     -- Highlighting definitions doesn't seem to work inside JS the way I'd expect. :thinking:
"     highlight_definitions = { enable = true },
"     -- highlight_current_scope = { enable = true },
"     smart_rename = {
"       enable = true,
"       keymaps = {
"         smart_rename = "<leader>r",
"       },
"     },
"     navigation = {
"       enable = true,
"       keymaps = {
"         goto_definition = "<leader>dd",
"         list_definitions = "<leader>dl",
"         goto_next_usage = "<a-j>",
"         goto_previous_usage = "<a-k>",
"       },
"     },
"   },
"   textobjects = {
"     select = {
"       enable = true,
"       keymaps = {
"         -- You can use the capture groups defined in textobjects.scm
"         ["af"] = "@function.outer",
"         ["if"] = "@function.inner",
"         -- Not really useful on how we use JS
"         -- ["ac"] = "@class.outer",
"         -- ["ic"] = "@class.inner",
"       },
"     },
"   },
" }
" EOF

" map <leader><C-r> :write <bar> edit <bar> TSBufEnable highlight<CR>
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Treesitter Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Iced Specific Settings
""""""""""""""""""""""""""" 
" Enable all the default mappings
let g:iced_enable_default_key_mappings = v:true
" Make formatting as easy as possible. Formatting on save 
" marks the file as needing to save, which is not great.
map <leader><c><f> :IcedFormatAll
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Iced Specific Settings
""""""""""""""""""""""""""" 
