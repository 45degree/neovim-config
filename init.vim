"=============================================================
"           __  __             __     ___
"          |  \/  |_   _    __ \ \   / (_)_ __ ___
"          | |\/| | | | |  / _` \ \ / /| | '_ ` _ \
"          | |  | | |_| | | (_| |\ V / | | | | | | |
"          |_|  |_|\__, |  \__, | \_/  |_|_| |_| |_|
"                  |___/      |_|
"
" =============================================================

" =============================================================
" 基本配置
" =============================================================

" 外观配置
set number         " 显示行号
set relativenumber " 显示相对行号 set cursorline     " 高亮当前行
set showmode       " 底部显示命令模式还是插入模式
set showcmd        " 命令模式下显示命令
set encoding=utf-8 " 编码格式为utf-8
set t_Co=256       " 设置为256色
set textwidth=100  " 每行显示100个字符
set wrap           " 折行
set linebreak      " 单词内部不折行
set wrapmargin=2   " 折行边缘字符数
set scrolloff=5    " 垂直翻滚时保留的行数
set laststatus=2   " 显示状态栏 0不显示, 1多窗口显示, 2显示
set ruler          " 状态栏显示光标当前位置
set termguicolors  " 支持24位彩色
set timeoutlen=500

" 缩进设置
" filetype indent on " 文件类型缩进检测
set autoindent     " 格式保持一致
set tabstop=4      " 设置tab键的宽度
set shiftwidth=4   " >> , <<, == 的宽度
set expandtab      " tab转换成空格
set softtabstop=4  " tab转换成空格的数量

" 搜索配置
set showmatch      " 自动高亮匹配括号
set hlsearch       " 高亮搜索结果
set incsearch      " 每输入一个字符自动跳到第一个搜索结果
set noignorecase   " 搜索不忽略大小写
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

inoremap jj <ESC>

" 解决插入模式下delete/backspace键失效问题
set backspace=2

" 启动鼠标支持
set mouse=a

" leader设置为空格
let g:mapleader="\<space>"
let g:maplocalleader = ","

" " =============================================================
" " 插件配置
" " =============================================================

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let g:ale_disable_lsp = 1

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    call dein#load_toml(stdpath('config').'/modules/appearance.toml')
    call dein#load_toml(stdpath('config').'/modules/general.toml')
    call dein#load_toml(stdpath('config').'/modules/git.toml')
    call dein#load_toml(stdpath('config').'/modules/textobj.toml')

    call dein#load_toml(stdpath('config').'/modules/code.toml')
    call dein#load_toml(stdpath('config').'/modules/lang/cpp.toml')
    call dein#end()

    call dein#begin('~/.cache/dein')
    if luaeval('require("option_config").get("rust")')
        call dein#load_toml(stdpath('config').'/option/lang/rust.toml')
    end

    call dein#load_toml(stdpath('config').'/option/lang/vala.toml')
    call dein#load_toml(stdpath('config').'/option/lang/latex.toml')
    call dein#end()
    call dein#save_state()

endif

syntax on          " 语法高亮

" 加载Config下的.vim文件
for file in split(glob(stdpath('config').'/Config/*.vim'), '\n')
    exe 'source' file
endfor

hi! Normal guibg=NONE
hi! SignColumn guibg=NONE
hi! MatchParen guifg=#F07178 guibg=#202331
hi! LineNr guibg=NONE guifg=#a6accd
hi! CursorLineNr guifg=#82aaff
hi! NormalFloat guifg=#A6ACCD guibg=#292D3E
hi! VertSplit guifg=#4E5579
