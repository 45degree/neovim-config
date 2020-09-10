let g:fcitx_version = system('command -v fcitx5')
if !empty(g:fcitx_version)
    let g:fcitx_version = 'fcitx5-remote'
else
    let g:fcitx_version = 'fcitx-remote'
endif

" fcitx 中英文切换
function! Fcitx2en()
    let input_status = system(g:fcitx_version)
    if input_status == 2
    let b:inputtoggle = 1
        call system(g:fcitx_version..' -c')
    endif
endfunction

function! Fcitx2zh()
    try
    if b:inputtoggle == 1
        call system(g:fcitx_version..' -o')
        let b:inputtoggle = 0
    endif
    catch /inputtoggle/
        let b:inputtoggle = 0
    endtry
endfunction

" Autocmds:
au InsertLeave * call Fcitx2en()
au InsertEnter * call Fcitx2zh()
