"""""""""""""""""""""""""""""""""" 
" NERDTree普通设置
"""""""""""""""""""""""""""""""""" 

" 自动关闭NERDTree
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif

"Show line number.
let g:NERDTreeShowlineNumber=1

"Show hide file.
let g:NERDTreeHidden=0

"Delete help information at the top
let NERDTreeMinimalUI=1

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

"""""""""""""""""""""""""""""""""" 
" NERDTree高亮设置
""""""""""""""""""""""""""""""""""

autocmd filetype nerdtree highlight haskell_icon ctermbg=none ctermfg=Red guifg=Red
autocmd filetype nerdtree highlight html_icon ctermbg=none ctermfg=Red guifg=#ffa500
autocmd filetype nerdtree highlight go_icon ctermbg=none ctermfg=Red guifg=Red

let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

" Disable all default highlight
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1

"you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:orangered = "FF4500"
let s:beige = "F5C06F"
let s:yellow = "FFFF00"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:Turquoise = "40E0D0"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = "FE405F"
let s:git_orange = "F54D27"
let s:gray = "808A87"

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['o'] = s:gray " sets the color of o files to blue
let g:NERDTreeExtensionHighlightColor['h'] = s:blue " sets the color of h files to blue
let g:NERDTreeExtensionHighlightColor['c'] = s:lightGreen " sets the color of c files to blue
let g:NERDTreeExtensionHighlightColor['cpp'] = s:lightGreen " sets the color of cpp files to blue
let g:NERDTreeExtensionHighlightColor['c++'] = s:lightGreen " sets the color of c++ files to blue
let g:NERDTreeExtensionHighlightColor['md'] = s:orange
let g:NERDTreeExtensionHighlightColor['json'] = s:yellow
let g:NERDTreeExtensionHighlightColor['vim'] = s:green
let g:NERDTreeExtensionHighlightColor['lua'] = s:purple
let g:NERDTreeExtensionHighlightColor['asm'] = s:orangered

let g:WebDevIconsDefaultFolderSymbolColor = s:gray
let g:WebDevIconsDefaultFileSymbolColor = s:gray
