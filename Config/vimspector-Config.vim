" 添加调试器接口
let g:vimspector_install_gadgets = []
let g:vimspector_base_dir = stdpath('config').'/vimspector-gadget'
call add(g:vimspector_install_gadgets, 'vscode-cpptools')
call add(g:vimspector_install_gadgets, 'CodeLLDB')

" vimspector 配置
let g:vimspector_enable_mappings = 'HUMAN'

" vimspector 模板生成器
function! s:read_template_into_buffer(template)
    let l:file = a:template
    if g:clap_enable_icon
       let l:file = a:template[4:]
    endif

    if !empty(findfile('.vimspector.json', '.'))
        call inputsave()
        let g:is_delete_orgin = input("detect a .vimspector.json file in current path, delete it or not? [Y(yes)/N(no)]:", 'N')
        call inputrestore()
        if g:is_delete_orgin ==? 'y' || g:is_delete_orgin ==? 'yes'
            call delete('.vimspector.json')
        else
            return
        endif
    end

    if bufexists('.vimspector.json')
        call deletebufline('.vimspector.json', 1, '$')
    else
        execute ':badd .vimspector.json'
    end

    let l:buffer_id = bufnr('.vimspector.json')
    let l:template_content = readfile(stdpath('config').'/vimspector_json/'.l:file)
    call bufload('.vimspector.json')
    call setbufline(l:buffer_id, 1, l:template_content)
    execute ':b '.buffer_id
endfunction

function! s:smart_concatenate(cur_dir, curline) abort
  if a:cur_dir[-1:] ==# '/'
    return a:cur_dir.a:curline
  else
    return a:cur_dir.'/'.a:curline
  endif
endfunction

function! s:get_current_entry() abort
  let curline = g:clap.display.getcurline()
  if g:clap_enable_icon
      let curline = curline[4:]
  endif
  let s:current_dir = expand(finddir('vimspector_json', stdpath('config')))
  return s:smart_concatenate(s:current_dir, curline)
endfunction

" 移动时预览
function! s:sync_on_move_impl() abort
  let current_entry = s:get_current_entry()
  let g:debug_c = current_entry
  if filereadable(current_entry)
    call clap#preview#file(current_entry)
  else
    call g:clap.preview.hide()
  endif
endfunction

function! s:get_all_template() abort
    let l:files = split(globpath(stdpath('config').'/vimspector_json', '*'))
    let l:all_file_name = []
    for item in l:files
        if has('win32')
            let l:file_name = split(item, '\')[-1]
        else
            let l:file_name = split(item, '/')[-1]
        endif
        if g:clap_enable_icon
            let l:file_name = clap#icon#get(item).' '.l:file_name
        end
        call add(l:all_file_name, l:file_name)
    endfor
    return l:all_file_name
endfunction

let g:clap_provider_json_template = {
            \ 'source': function('s:get_all_template'),
            \ 'on_move': function('s:sync_on_move_impl'),
            \ 'sink': function('s:read_template_into_buffer'),
            \ 'syntax': 'clap_files'
            \ }

function! Generator_debug_template() abort
    execute "Clap json_template"
endfunction

sign define vimspectorBP text= texthl=Normal
sign define vimspectorBPDisabled text= texthl=Normal
