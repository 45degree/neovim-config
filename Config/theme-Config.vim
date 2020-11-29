" 设置主题颜色
let g:material_terminal_italics = 1
let g:material_theme_style = 'darker'
colorscheme material
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" Doxygen高亮
autocmd FileType c set syntax=cpp.doxygen
autocmd FileType cpp set syntax=cpp.doxygen

" spaceline配置
let g:spaceline_custom_vim_status = {"n": " ","V":" ","v":" ","\<C-v>": " ","i":" ","R":" ","s":" ","t":" ","c":" ","!":" "}
let g:spaceline_colorscheme = 'space'
let g:spaceline_seperate_style = 'arrow-fade'
let g:spaceline_git_branch_icon = ' '
let g:spaceline_diff_tool = "git-gutter"
let g:spaceline_custom_diff_icon = [' ',' ',' ']

" vim-buffet配置
let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"

function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer    gui=NONE guibg=#50fa7b guifg=#282a36
  hi! BuffetActiveBuffer     gui=NONE guibg=#bd93f9 guifg=#282a36
  hi! BuffetBuffer           gui=NONE guibg=#282a36 guifg=#6272a4
  hi! BuffetModCurrentBuffer gui=NONE guibg=#8be9fd guifg=#282a36
  hi! BuffetModActiveBuffer  gui=NONE guibg=#ffb86c guifg=#282a36
  hi! BuffetModBuffer        gui=NONE guibg=#ff5555 guifg=#282a36
  hi! BuffetTrunc            gui=NONE guibg=#bd93f9 guifg=#282a36
  hi! BuffetTab              gui=NONE guibg=#bd93f9 guifg=#282a36
endfunction
