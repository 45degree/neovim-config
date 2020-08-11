call which_key#register('<space>', "g:which_key_map")
let g:which_key_map={}

let g:which_key_map.f = {
     \ 'name' : '+文件',
     \ 's' : [':w', '保存当前文件'],
     \ 'S' : [':wa', '保存所有文件'],
     \ 'c' : [':e $MYVIMRC', '打开vim配置文件'],
     \ }

let g:which_key_map.s = {
     \ 'name' : '+模糊搜索',
     \ 'f' : [':Files', '文件夹内查找文件'],
     \ 'a' : [':Ag', '文件夹内查找文件内容'],
     \ 'g':  [':GFiles', 'git项目内查找文件'],
     \}

let g:which_key_map.c = {
     \ 'name': '+代码',
     \ '1': {
     \     'name': '+latex',
     \     'b': [':CocCommand latex.Build', 'latex编译'],
     \     'p': [':CocCommand latex.ForwardSearch', 'latex预览'],
     \ },
     \ '2': {
     \     'name': '+markdown',
     \     'p': ['<Plug>MarkdownPreview', 'markdown预览'],
     \     's': ['<Plug>MarkdownPreviewStop', 'markdown停止预览'],
     \ },
     \ 'f' : [':Neoformat', '格式化代码'],
     \ 't': [':TagbarToggle', '打开代码大纲']
     \}

let g:which_key_map.T = {
     \'name': '+终端',
     \}

let g:which_key_map.t = [':CocCommand explorer', "打开文件树"]

let g:which_key_map.w={
     \ 'name' : '+窗口' ,
     \ 'd' : ['<C-W>c'     , '删除当前窗口']          ,
     \ 'w' : ['<C-W>w'     , '移动到其他窗口']        ,
     \ 'h' : ['<C-W>h'     , '移动到左边窗口']        ,
     \ 'j' : ['<C-W>j'     , '移动到下边窗口']        ,
     \ 'l' : ['<C-W>l'     , '移动到右边窗口']        ,
     \ 'k' : ['<C-W>k'     , '移动到上边窗口']        ,
     \ 'H' : ['<C-W>5<'    , '窗口向左扩展']          ,
     \ 'J' : [':resize +5' , '窗口向下扩展']          ,
     \ 'L' : ['<C-W>5>'    , '窗口向右扩展']          ,
     \ 'K' : [':resize -5' , '窗口向上扩展']          ,
     \ '=' : ['<C-W>='     , '平衡调整窗口']          ,
     \ 's' : ['<C-W>s'     , '上下分屏']              ,
     \ 'v' : ['<C-W>v'     , '左右分屏']              ,
     \ }
