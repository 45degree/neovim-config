local icons = require('icons')
return {
  'hedyhli/outline.nvim',
  event = 'LspAttach',
  opts = {
    outline_window = {
      -- Where to open the split window: right/left
      position = 'right',
      width = 25,
      relative_width = true,
      focus_on_open = false,
    },

    providers = {
      priority = { 'lsp', 'coc', 'markdown', 'norg' },
      lsp = {
        -- Lsp client names to ignore
        blacklist_clients = { 'null-ls' },
      },
    },

    symbols = {
      icons = {
        File = { icon = icons.kind.File, hl = 'Identifier' },
        Module = { icon = icons.kind.Module, hl = 'Include' },
        Namespace = { icon = icons.kind.Namespace, hl = 'Include' },
        Package = { icon = icons.kind.Package, hl = 'Include' },
        Class = { icon = icons.kind.Class, hl = 'Type' },
        Method = { icon = icons.kind.Method, hl = 'Function' },
        Property = { icon = icons.kind.Property, hl = 'Identifier' },
        Field = { icon = icons.kind.Field, hl = 'Identifier' },
        Constructor = { icon = icons.kind.Constructor, hl = 'Special' },
        Enum = { icon = icons.kind.Enum, hl = 'Type' },
        Interface = { icon = icons.kind.Interface, hl = 'Type' },
        Function = { icon = icons.kind.Function, hl = 'Function' },
        Variable = { icon = icons.kind.Variable, hl = 'Constant' },
        Constant = { icon = icons.kind.Constant, hl = 'Constant' },
        String = { icon = icons.kind.String, hl = 'String' },
        Number = { icon = icons.kind.Number, hl = 'Number' },
        Boolean = { icon = icons.kind.Boolean, hl = 'Boolean' },
        Array = { icon = icons.kind.Array, hl = 'Constant' },
        Object = { icon = icons.kind.Object, hl = 'Type' },
        Key = { icon = icons.kind.Key, hl = 'Type' },
        Null = { icon = icons.kind.Null, hl = 'Type' },
        EnumMember = { icon = icons.kind.EnumMember, hl = 'Identifier' },
        Struct = { icon = icons.kind.Struct, hl = 'Structure' },
        Event = { icon = icons.kind.Event, hl = 'Type' },
        Operator = { icon = icons.kind.Operator, hl = 'Identifier' },
        TypeParameter = { icon = icons.kind.TypeParameter, hl = 'Identifier' },
        Component = { icon = icons.kind.Component, hl = 'Function' },
        Fragment = { icon = icons.kind.Fragment, hl = 'Constant' },
        TypeAlias = { icon = icons.kind.TypeAlias, hl = 'Type' },
        Parameter = { icon = icons.kind.Parameter, hl = 'Identifier' },
        StaticMethod = { icon = icons.kind.StaticMethod, hl = 'Function' },
        Macro = { icon = icons.kind.Macro, hl = 'Function' },
      },
    },
  },
}
