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
Plug 'neovim/nvim-lsp'
Plug 'mattboehm/vim-accordion'
Plug 'lukas-reineke/indent-blankline.nvim'

" Plug 'windwp/nvim-autopairs'
Plug 'cohama/lexima.vim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Language Specific
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Typescript
" Plug 'jose-elias-alvarez/typescript.nvim'
Plug 'pmizio/typescript-tools.nvim'

" General Languages
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Autocomplete
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" JSDoc integration
Plug 'danymat/neogen'

" Luasnip for cmp plugin
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-omni'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Javascript
" Plug 'prettier/vim-prettier'
Plug 'sbdchd/neoformat'

" Clojure
" Plug 'guns/vim-sexp',    {'for': 'clojure'}
" Plug 'liquidz/vim-iced', {'for': 'clojure'}

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

" Also make sure when searching that the cursor centers on screen
" https://vim.fandom.com/wiki/Make_search_results_appear_in_the_middle_of_the_screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

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
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

" Set up shortcuts to dance around diagostics
map <leader>v :lua vim.diagnostic.open_float()<CR>
map <leader>, :lua vim.diagnostic.goto_next()<CR>
map <leader>. :lua vim.diagnostic.goto_prev()<CR>


" Fixes SQL autocompletion errors:
" https://github.com/neovim/neovim/issues/14433
" Default to static completion for SQL
let g:omni_sql_default_compl_type = 'syntax'


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
" augroup AutomaticPrettier
"   autocmd!
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.js :Prettier
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.mjs :Prettier
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.jsx :Prettier
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.tsx :Prettier
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.ts :Prettier
" augroup END
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
" lua <<EOF

" -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
" -- local capabilities = vim.lsp.protocol.make_client_capabilities()
" -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

" -- require("typescript").setup({})
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
function! g:GroupSuffix()
  if mode() ==# 'i' && &paste
    return '2'
  endif
  if &modified
    return '1'
  endif
  return ''
endfunction

function! g:CrystallineStatuslineFn(winnr)
  let g:crystalline_group_suffix = g:GroupSuffix()
  let l:curr = a:winnr == winnr()
  let l:s = ''

  if l:curr
    let l:s .= crystalline#ModeSection(0, 'A', 'B')
  else
    let l:s .= crystalline#HiItem('Fill')
  endif
  let l:s .= ' %f%h%w%m%r '

  let l:s .= '%='
  if l:curr
    let l:s .= crystalline#Sep(1, 'Fill', 'B') . '%{&paste ? " PASTE " : " "}'
    let l:s .= crystalline#Sep(1, 'B', 'A')
  endif
  if winwidth(a:winnr) > 80
    let l:s .= ' %{&ft} %l/%L %2v '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! g:CrystallineTablineFn()
  let l:max_width = &columns
  let l:right = '%='

  let l:right .= crystalline#Sep(1, 'TabFill', 'TabType')
  let l:max_width -= 1

  let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
  let l:right .= l:vimlabel
  let l:max_width -= strchars(l:vimlabel)

  let l:max_tabs = 23

  return crystalline#DefaultTabline({
        \ 'enable_sep': 1,
        \ 'max_tabs': l:max_tabs,
        \ 'max_width': l:max_width
        \ }) . l:right
endfunction

set showtabline=1
set guioptions-=e
set laststatus=2
let g:crystalline_theme = 'ayu'
let g:crystalline_auto_prefix_groups = 1
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
  auto_install = true,
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
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
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
      { name = 'path' },
      { name = 'buffer' },
      { name = 'luasnip' },
      { name = 'omni' },
    })
  })

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
EOF
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END nvim-compe Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START lsp_signature Specific Settings
""""""""""""""""""""""""""" 
" lua <<EOF
" require 'lsp_signature'.on_attach()
" EOF
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END lsp_signature Specific Settings
""""""""""""""""""""""""""" 




""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START LuaSnip Specific Settings
""""""""""""""""""""""""""" 
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END LuaSnip Specific Settings
""""""""""""""""""""""""""" 



""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START vim-sandwich Specific Settings
""""""""""""""""""""""""""" 
" Make sure when using surround commands to not move cursor.
call operator#sandwich#set('all', 'all', 'cursor', 'keep')
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END vim-sandwich Specific Settings
""""""""""""""""""""""""""" 






""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START nvim-autopairs Specific Settings
""""""""""""""""""""""""""" 
" lua << EOF
" require("nvim-autopairs").setup {}

" local cmp_autopairs = require('nvim-autopairs.completion.cmp')
" local cmp = require('cmp')
" cmp.event:on(
"   'confirm_done',
"   cmp_autopairs.on_confirm_done()
" )
" EOF
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END nvim-autopairs Specific Settings
""""""""""""""""""""""""""" 




""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START indent-blankline.nvim Specific Settings
""""""""""""""""""""""""""" 

lua << EOF
vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require("ibl").setup({
--   use_treesitter = true,
--   show_current_context = true,
--   show_current_context_start = true,
--   context_highlight_list = { "Blue" },
--   context_patterns = {
--     -- NOTE: indent-blankline's defaults
--     "class",
--     "^func",
--     "method",
--     "^if",
--     "while",
--     "for",
--     "with",
--     "try",
--     "except",
--     "arguments",
--     "argument_list",
--     "object",
--     "dictionary",
--     "element",
--     "table",
--     "tuple",
-- 
--     -- NOTE: better JavaScript/TypeScript support
--     "return_statement",
--     "statement_block",
--   },
-- 
--   bufname_exclude = { "" }, -- Disables the plugin in hover() popups and new files
-- 
--   char_highlight_list = { "VertSplit" },
-- 
-- 
})
EOF
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END indent-blankline.nvim Specific Settings
""""""""""""""""""""""""""" 












""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START neogen Specific Settings
""""""""""""""""""""""""""" 

lua << EOF

require('neogen').setup {
  enabled = true,             --if you want to disable Neogen
  input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
  snippet_engine = "luasnip",
  javascript = {
    template = {
      annotation_convention = "jsdoc",
      jsdoc = {
        { nil, "/**" },
        { nil, " * $1" },
        { "parameters", " * @param {any} %s $1"},
        { "return_statement", " * @return {any} %s $1"},
        { nil, " */"},
      }
    }
  },
  typescript = {
    template = {
      annotation_convention = "tsdoc",
    }
  },

}

EOF
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END indent-blankline.nvim Specific Settings
""""""""""""""""""""""""""" 

""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" START neoformat Specific Settings
""""""""""""""""""""""""""" 
" Ensure that we try to use the local Prettier install
let g:neoformat_try_node_exe = 1

let g:neoformat_json_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--format=json'],
            \ }

let g:neoformat_enabled_javascript = [ 'prettier' ]
let g:neoformat_enabled_typescript = [ 'prettier' ]

" Set it up so that Prettier runs on save for .js .jsx and .ts files
"
" NOTE: Not the default values from Neoformat readme, using fixed augroup 
" from this issue: https://github.com/sbdchd/neoformat/issues/134
augroup AutomaticPrettier
  autocmd!
  au BufWritePre *.js try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
  au BufWritePre *.mjs try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
  au BufWritePre *.jsx try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
  au BufWritePre *.tsx try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
  au BufWritePre *.ts try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END
""""""""""""""""""""""""""" 
""""""""""""""""""""""""""" END neoformat Specific Settings
""""""""""""""""""""""""""" 


"""""""""""""""""""""""""""
""""""""""""""""""""""""""" START typescript-tools Specific Settings
"""""""""""""""""""""""""""
lua << EOF
require("typescript-tools").setup {
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = "all",
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = true,
    include_completions_with_insert_text = true,
    -- CodeLens
    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    code_lens = "off",
    -- by default code lenses are displayed on all referencable values and for some of you it can
    -- be too much this option reduce count of them by removing member references from lenses
    disable_member_code_lens = true,

    -- Ensure JavaScript projects get TS analysis by default
    implicitProjectConfiguration = { 
      checkJs = true
    },
  },
}
EOF

"""""""""""""""""""""""""""
""""""""""""""""""""""""""" END typescript-tools Specific Settings
"""""""""""""""""""""""""""




"""""""""""""""""""""""""""
""""""""""""""""""""""""""" START ale Specific Settings
"""""""""""""""""""""""""""
au BufRead,BufNewFile cloud-formation.yaml set filetype=yaml.cloudformation
au BufRead,BufNewFile *.template.yaml set filetype=yaml.cloudformation
"""""""""""""""""""""""""""
""""""""""""""""""""""""""" END ale Specific Settings
"""""""""""""""""""""""""""
