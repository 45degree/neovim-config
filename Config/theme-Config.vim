" 设置主题颜色
let g:material_terminal_italics = 1
let g:material_theme_style = 'darker'
colorscheme OceanicNext
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
