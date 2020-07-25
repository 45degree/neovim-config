"=============================================================
"           __  __             __     ___
"          |  \/  |_   _    __ \ \   / (_)_ __ ___
"          | |\/| | | | |  / _` \ \ / /| | '_ ` _ \
"          | |  | | |_| | | (_| |\ V / | | | | | | |
"          |_|  |_|\__, |  \__, | \_/  |_|_| |_| |_|
"                  |___/      |_|
"
" =========================说明文档============================
"按键功能:
"   <leader>t                   打开目录
"   <leader>8                   打开文件大纲
"   <f3>                        打开底部终端
"   <f4>                        打开一个接近满屏的终端
"   gc                          快速注释代码
"   gcgc                        取消代码注释
"   ss                          easymotion
"   <leader><Ctrl-p>            文件内容模糊搜索
"   <Ctrl-p>                    文件模糊搜索
"   Far <src> <dst> <path/file> 在file中所有的<src>替换成<dst>
" =============================================================

" =============================================================
" 基本配置
" =============================================================

" 外观配置
set number         " 显示行号
set relativenumber " 显示相对行号
set cursorline     " 高亮当前行
syntax on          " 语法高亮
set showmode       " 底部显示命令模式还是插入模式
set showcmd        " 命令模式下显示命令
set encoding=utf-8 " 编码格式为utf-8
set t_Co=256       " 设置为256色
set textwidth=100  " 每行显示80个字符
set wrap           " 折行
set linebreak      " 单词内部不折行
set wrapmargin=2   " 折行边缘字符数
set scrolloff=5    " 垂直翻滚时保留的行数
set laststatus=2   " 显示状态栏 0不显示, 1多窗口显示, 2显示
set ruler          " 状态栏显示光标当前位置

" 缩进设置
" filetype indent on " 文件类型缩进检测
set autoindent     " 格式保持一致
set tabstop=4      " 设置tan键的宽度
set shiftwidth=4   " >> , <<, == 的宽度
set expandtab      " tab转换成空格
set softtabstop=4  " tab转换成空格的数量

" 搜索配置
set showmatch      " 自动高亮匹配括号
set hlsearch       " 高亮搜索结果
set incsearch      " 每输入一个字符自动跳到第一个搜索结果
set ignorecase     " 搜索忽略大小写
set smartcase      " 搜索时智能忽略大小写

" 编辑
" set spell spelllang=en_us,cjk  " 英语单词拼写检查
set nobackup                   " 不创建备份文件
set noswapfile                 " 不创建交换文件
set undofile                   " 保留撤销历史
set autochdir                  " 自动切换工作目录
set noerrorbells               " 出错不发出响声
set visualbell                 " 出错时发出视觉提示
set history=1000               " 记住1000次历史操作
set autoread                   " 打开文件监视
set listchars=tab:>-,trail:-   " 末尾空格、tab用-高亮
set list
set wildmenu
set wildmode=longest:list,full " 底部命令tab自动补全
set clipboard=unnamedplus      " 设置vim使用系统剪切板

" 禁止使用方向键
nnoremap <Up> :echo "use k"<CR>
nnoremap <Left> :echo "use h"<CR>
nnoremap <Right> :echo "use l"<CR>
nnoremap <Down> :echo "use j"<CR>

" inoremap jj <ESC>
" 解决插入模式下delete/backspace键失效问题
set backspace=2

" 启动鼠标支持
set mouse=a

" leader设置为空格
let mapleader="\<space>"

" =============================================================
" 插件配置
" =============================================================

" 通用插件
call plug#begin(stdpath('config').'/plugged')

    " 主题颜色
    Plug 'flazz/vim-colorschemes'

    " 彩虹括号
    Plug 'luochen1990/rainbow'
    " 配置插件rainbow
    let g:rainbow_active = 1

    " coc.nvim配置
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions=['coc-clangd', 'coc-explorer', 'coc-vimlsp', 'coc-texlab']
    noremap <silent> <leader>t :CocCommand explorer<cr>

    " Rust配置
    Plug 'rust-lang/rust.vim'

    " Rust补全
    Plug 'racer-rust/vim-racer'

    Plug 'bling/vim-bufferline'

    " airline配置
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " vim启动页面
    Plug 'mhinz/vim-startify'

    " vim缩进线
    Plug 'yggdroot/indentline'
    let g:indentLine_conceallevel = 0

    " 快速定位插件
    Plug 'easymotion/vim-easymotion'
    nmap ss <Plug>(easymotion-s2)

    " 代码提纲
    Plug 'majutsushi/tagbar'
    nmap <leader>8 :TagbarToggle<CR>

    " 语法高亮
    Plug 'sheerun/vim-polyglot'
    Plug 'jackguo380/vim-lsp-cxx-highlight'

    " 括号补全
    Plug 'jiangmiao/auto-pairs'

    "git配置
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'

    " Doxygen工具
    Plug 'vim-scripts/DoxygenToolkit.vim'

    " 模糊搜索
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    Plug 'junegunn/fzf.vim'
    Plug 'brooth/far.vim'
    noremap  <silent> <c-p> :Files<cr>
    noremap <silent> <leader><c-p> :Ag<cr>

    " 格式化代码
    Plug 'sbdchd/neoformat'

    " 静态检查
    " Plug 'dense-analysis/ale'

    " 成对编辑
    Plug 'tpope/vim-surround'

    " 快速注释代码
    Plug 'tpope/vim-commentary'

    " 浮动终端
    Plug 'voldikss/vim-floaterm'

    " vim扩展文本对象
    Plug 'bkad/CamelCaseMotion'
    Plug  'vim-scripts/argtextobj.vim'

    " markdown
    Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'}

    " debug
    Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-bash --force-enable-rust'}
call plug#end()

" rainbow配置, rainbow配置会对NERDTree和vim-devicons有影响
let g:rainbow_conf = {
\    'separately': {
\       'nerdtree': 0
\    }
\}

" 加载Config下的.vim文件
for file in split(glob(stdpath('config').'/Config/*.vim'), '\n')
    exe 'source' file
endfor
