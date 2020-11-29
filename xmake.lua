option("lua support")
    set_default(false)
    set_showmenu(true)
    set_category("lua support")
    set_description("支持lua lsp 和 lua 代码调试")

option("vala support")
    set_default(false)
    set_showmenu(true)
    set_category("vala support")
    set_description("支持vala lsp 和 vala 语法高亮")

option("rust support")
    set_default(false)
    set_showmenu(true)
    set_category("rust support")
    set_description("支持rust lsp、rust 语法高亮和 rust 代码调试")

option("latex support")
    set_default(false)
    set_showmenu(true)
    set_category("latex support")
    set_description("支持latex lsp 和 latex 预览")

target("my-nvim")

    before_build(function ()
        -- 检查相关依赖

        -- 检查dein.vim并安装

    end)

    on_build(function()
        -- 生成配置选项

    end)

    after_build(function()
        -- dein.vim 安装插件

    end)

target_end()
