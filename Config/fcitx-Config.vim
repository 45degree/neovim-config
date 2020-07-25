" fcitx 中英文切换
function! Fcitx2en()
    let input_status = system('fcitx-remote')
    if input_status == 2
        let b:inputtoggle = 1
        call system('fcitx-remote -c')
    endif
endfunction
function! Fcitx2zh()
    try
    if b:inputtoggle == 1
        call system('fcitx-remote -o')
        let b:inputtoggle = 0
    endif
    catch /inputtoggle/
        let b:inputtoggle = 0
    endtry
endfunction
" Autocmds:
au InsertLeave * call Fcitx2en()
au InsertEnter * call Fcitx2zh()
