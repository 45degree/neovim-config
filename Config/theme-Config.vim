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
