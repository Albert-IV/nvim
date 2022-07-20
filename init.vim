" START PLUGINS
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
call plug#begin(stdpath('config') . '/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme(s) / Themes / Status Lines
""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/seoul256.vim'
Plug 'sainnhe/edge'

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
Plug 'mileszs/ack.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neovim/nvim-lsp'
Plug 'ray-x/lsp_signature.nvim'
" Plug 'godlygeek/tabular'
Plug 'mattboehm/vim-accordion'
Plug 'windwp/nvim-autopairs'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Language Specific
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" General Languages
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
" Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'

" Coffeescript...
Plug 'kchmck/vim-coffee-script'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Autocomplete
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" completion-nvim
" Plug 'haorenW1025/completion-nvim'
" Plug 'nvim-treesitter/completion-treesitter'
" Plug 'codota/tabnine-vim'
" Plug 'aca/completion-tabnine', { 'do': './install.sh' }

" Old autocomplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/deoplete-lsp'

" Javascript
Plug 'prettier/vim-prettier'

" Clojure
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}

" CSS
" Plug 'ap/vim-css-color'

" Wrap up so we can use the plugins later in our config
call plug#end()
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" END PLUGINS
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Theme settings.  Set later in the config, but this is needed for the edge
" colortheme
if (has("termguicolors"))
  set termguicolors
endif

let g:edge_style = 'default'

" Italics for comments, no italics for code
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 0

" Let tmux coloring come through (IE highlight active panes
let g:edge_transparent_background = 1

" Enables plugin-specific code diagnostics
let g:edge_diagnostic_line_highlight = 0

colorscheme edge

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

" Set up backticks as matching pairs in Javascript
augroup JavaScriptTemplating
  " This doesn't work... 
  " autocmd FileType javascript set mps+=`:`

  " Doesn't work either RIP
  " if exists("b:match_words") | 
  "   autocmd FileType javascript let b:match_words=b:match_words.',`:`' |
  " endif
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
  " if (has("termguicolors"))
  "   set termguicolors
  " endif
endif

" use tab / shift tab to go through autocomplete options
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set up autocomplete menu to resemble zsh
set wildmenu
set wildmode=full

" Make VIM remember more previously ran commands
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

" Ensure autocomplete doesn't trigger a scratch buffer
set completeopt-=preview

" Set folding to use syntax rather than manual...
set foldmethod=syntax
set nofoldenable



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
  autocmd BufWritePre,FileWritePre,FileAppendPre *.mjs :Prettier
  autocmd BufWritePre,FileWritePre,FileAppendPre *.jsx :Prettier
  autocmd BufWritePre,FileWritePre,FileAppendPre *.tsx :Prettier
  autocmd BufWritePre,FileWritePre,FileAppendPre *.ts :Prettier
augroup END
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Prettier Specific Settings
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
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
" let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
" command! -bang -nargs=? -complete=dir Files
"      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
" nnoremap <C-p> :<C-u>FZF<CR> 
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
let g:ackpreview = 0
let g:ack_autofold_results = 1
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END ack Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START vim-lsp Specific Settings
""""""""""""""""""""""""""" 
" Sets up TS server LSP with default options
lua <<EOF
require'lspconfig'.tsserver.setup{}
EOF

" " Set up Clojure LSP support
" lua <<EOF
" require'lspconfig'.clojure_lsp.setup{}
" EOF

" " Set up Haskell LSP support
" lua << EOF
" require'lspconfig'.ghcide.setup{}
" EOF

" Handy bits to interact with LSP
nnoremap <silent>K          <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent><leader>?  <cmd>lua vim.lsp.buf.code_action()<CR>

" View where the function was defined
nnoremap <silent>gd    <cmd>lua vim.lsp.buf.definition()<CR>

" Always show the sign gutter, since LSP will add to it as you type
set signcolumn=yes
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END vim-lsp Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Deoplete Specific Settings
""""""""""""""""""""""""""" 
" Enable Deoplete
" let g:deoplete#enable_at_startup = 1
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
  " if a:current
  "   let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
  " endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', '') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
  else
    let l:s .= ' '
  endif

  return l:s
  endif

  return l:s
endfunction

" function! TabLine()
"   let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
"   return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
" endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
" let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'default'

set showtabline=1
set guioptions-=e
set laststatus=2
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END Crystalline Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START Treesitter Specific Settings
""""""""""""""""""""""""""" 
" Enable it all
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "json", "typescript" },
  highlight = {
    enable = true,
  },
  refactor = {
    -- Highlighting definitions doesn't seem to work inside JS the way I'd expect. :thinking:
    -- highlight_definitions = { enable = true },
    -- highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<leader>r",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "<leader>dd",
        list_definitions = "<leader>dl",
        goto_next_usage = "<a-j>",
        goto_previous_usage = "<a-k>",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        -- Not really useful on how we use JS
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      },
    },
  },
}
EOF

map <leader><C-r> :write <bar> edit <bar> TSBufEnable highlight<CR>
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



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START completion-nvim Specific Settings
""""""""""""""""""""""""""" 
" " NOTE: the nvim LSP section has settings to hook into the completion-nvim
" " library. Check the LSP section for `on_attach=require'completion'.on_attach`

" " Use completion-nvim in every buffer
" augroup CompletionNvimInit
"   autocmd BufEnter * lua require'completion'.on_attach()
" augroup END

" " Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect

" " Avoid showing message extra message when using completion
" set shortmess+=c

""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END completion-nvim Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START completion-treesitter Specific Settings
""""""""""""""""""""""""""" 
" Configure the completion chains
" let g:completion_chain_complete_list = {
" 			\'default' : {
" 			\	'default' : [
" 			\		{'complete_items' : ['lsp', 'snippet']},
" 			\		{'mode' : 'file'}
" 			\	],
" 			\	'comment' : [],
" 			\	'string' : []
" 			\	},
" 			\'clojure' : [
" 			\	{'complete_items': ['ts', 'lsp']}
" 			\	],
" 			\'haskell' : [
" 			\	{'complete_items': ['ts', 'lsp']}
" 			\	],
" 			\'javascript' : [
" 			\	{'complete_items': ['ts', 'lsp']}
" 			\	],
" 			\'javascriptreact' : [
" 			\	{'complete_items': ['ts', 'lsp']}
" 			\	],
" 			\'typescript' : [
" 			\	{'complete_items': ['ts', 'lsp']}
" 			\	],
" 			\'vim' : [
" 			\	{'complete_items': ['snippet']},
" 			\	{'mode' : 'cmd'}
" 			\	],
" 			\}

""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END completion-treesitter Specific Settings
""""""""""""""""""""""""""" 

""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START tabular Specific Settings
""""""""""""""""""""""""""" 
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END tabular Specific Settings
""""""""""""""""""""""""""" 


""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START telescope Specific Settings
""""""""""""""""""""""""""" 
nnoremap <C-p>      <cmd>lua require'telescope.builtin'.git_files()<CR>
nnoremap <leader>p  <cmd>lua require'telescope.builtin'.find_files()<CR>

lua <<EOF
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = ">",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    -- file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = { 'package-lock.json' },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
    file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
    grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
    qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
    path_display = {
    },
    layout_config = {
      width = 0.75,
      prompt_position = "bottom",
      preview_cutoff = 120,
    }
  }
}
EOF

" Exit telescope when exiting insert mode
lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF

nnoremap <C-Space> :Telescope buffers<cr>

""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END telescope Specific Settings
""""""""""""""""""""""""""" 

""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START nvim-compe Specific Settings
""""""""""""""""""""""""""" 
set completeopt=menuone,noselect

lua <<EOF
local cmp = require'cmp'
cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })
EOF
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END nvim-compe Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START lsp_signature Specific Settings
""""""""""""""""""""""""""" 
lua <<EOF
require 'lsp_signature'.on_attach()
EOF
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END lsp_signature Specific Settings
""""""""""""""""""""""""""" 




""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START nvim-autopairs Specific Settings
""""""""""""""""""""""""""" 
lua << EOF
require("nvim-autopairs").setup {}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
EOF
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END nvim-autopairs Specific Settings
""""""""""""""""""""""""""" 
