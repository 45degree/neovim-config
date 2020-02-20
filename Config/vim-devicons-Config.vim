" 启动NERDTree
let g:webdevicons_enable_nerdtree = 1

" 在NERDTree中不显示括号
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
let g:airline_powerline_fonts = 1
let g:webdevicons_enable_vimfiler = 0
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0

" 加入vim-airline的tabline
let g:webdevicons_enable_airline_tabline=1

"  加入vim-airline的statusline
let g:webdevicons_enable_airline_statusline = 1



" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" enable custom folder/directory glyph exact matching
" (enabled by default when g:WebDevIconsUnicodeDecorateFolderNodes is set to 1)
let WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1

let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['asm'] = ''
