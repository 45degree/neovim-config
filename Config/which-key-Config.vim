" which_key 按键映射
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

call which_key#register('<space>', "g:which_key_map")
let g:which_key_map={}

let g:which_key_map.f = {
     \ 'name' : '+文件',
     \ 's' : [':w', '保存当前文件'],
     \ 'S' : [':wa', '保存所有文件'],
     \ 'c' : [':e $MYVIMRC', '打开vim配置文件'],
     \ 'a' : [':DashboardNewFile', '添加一个文件']
     \ }

let g:which_key_map.s = {
     \ 'name' : '+Search',
     \ 'f' : [':Telescope find_files', '文件夹内查找文件'],
     \ 'a' : [':Telescope live_grep', '文件夹内查找文件内容'],
     \ 'g' : [':Telescope git_files', 'git项目内查找文件'],
     \ 'c' : [':Telescope colorscheme', '改变颜色'],
     \ 'h' : [':Telescope oldfiles', '查看历史'],
     \ 'm' : [':Telescope marks', 'Mark 查找'],
     \ 'b' : [':Telescope buffers', '查找所有buffer'],
     \}

let g:which_key_map.g = {
    \ 'name' : '+Generator',
    \ 't': {
    \   'name': '+翻译',
    \   'e': [':TranslateW --target_lang=zh --source_lang=en', '(单词)英译中'],
    \   'z': [':TranslateW --target_lang=en --source_lang=zh', '(单词)中译英']
    \ }
    \}

let g:which_key_map.S = {
     \ 'name' : '+Session',
     \ 's' : [':SessionSave', 'Session 保存'],
     \ 'l' : [':SessionLoad', 'Session 加载']
     \}

let g:which_key_map.c = {
    \ 'name': '+代码',
    \ '2': {
    \     'name': '+markdown',
    \     'p': ['<Plug>MarkdownPreview', 'markdown预览'],
    \     's': ['<Plug>MarkdownPreviewStop', 'markdown停止预览'],
    \ },
    \ 'g': {
    \     'name': '+git',
    \     'p': [':GitGutterPreviewHunk', '显示Git更改功能'],
    \     'do': [':DiffviewOpen', 'git diff open'],
    \     'dc': [':DiffviewClose', 'git diff close'],
    \ },
    \ 'f': [':Format', '格式化代码'],
    \ 't': [':Vista!!', '打开代码大纲'],
    \ 'd': {
    \     'name': '+debug',
    \     'g': ['Generator_debug_template()', '生成debug模板'],
    \     's': ['<Plug>VimspectorBalloonEval', '显示变量值'],
    \     'c': [':VimspectorReset', '关闭调试'],
    \ },
    \}

let g:which_key_map.t = [':NvimTreeToggle', "打开文件树"]

let g:which_key_map.w={
     \ 'name' : '+窗口' ,
     \ 'c' : ['<Plug>(choosewin)', '选择窗口']              ,
     \ 'd' : ['<C-W>c'           , '删除当前窗口']          ,
     \ 'w' : ['<C-W>w'           , '移动到其他窗口']        ,
     \ 'h' : ['<C-W>h'           , '移动到左边窗口']        ,
     \ 'j' : ['<C-W>j'           , '移动到下边窗口']        ,
     \ 'l' : ['<C-W>l'           , '移动到右边窗口']        ,
     \ 'k' : ['<C-W>k'           , '移动到上边窗口']        ,
     \ 'H' : ['<C-W>5<'          , '窗口向左扩展']          ,
     \ 'J' : [':resize +5'       , '窗口向下扩展']          ,
     \ 'L' : ['<C-W>5>'          , '窗口向右扩展']          ,
     \ 'K' : [':resize -5'       , '窗口向上扩展']          ,
     \ '=' : ['<C-W>='           , '平衡调整窗口']          ,
     \ 's' : ['<C-W>s'           , '上下分屏']              ,
     \ 'v' : ['<C-W>v'           , '左右分屏']              ,
     \ }

let g:which_key_map.b={
    \ 'name': '+Buffer',
    \ '1': [':BufferGoto 1', '移动到buffer 1'],
    \ '2': [':BufferGoto 2', '移动到buffer 2'],
    \ '3': [':BufferGoto 3', '移动到buffer 3'],
    \ '4': [':BufferGoto 4', '移动到buffer 4'],
    \ '5': [':BufferGoto 5', '移动到buffer 5'],
    \ '6': [':BufferGoto 6', '移动到buffer 6'],
    \ '7': [':BufferGoto 7', '移动到buffer 7'],
    \ '8': [':BufferGoto 8', '移动到buffer 8']
    \}
