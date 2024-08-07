local icons = {}

icons.layout = {
  list = '•',
  tab = '→',
  wrap = '↪',
}

icons.gitsigns = {
  -- Change type
  added = ' ',
  modified = ' ',
  deleted = ' ',
  renamed = ' ',
  -- Status type
  untracked = ' ',
  ignored = ' ',
  unstaged = ' ',
  staged = ' ',
  conflict = ' ',
}

icons.widgets = {
  cmd = ' ',
  config = '',
  event = '',
  ft = ' ',
  init = ' ',
  import = ' ',
  keys = ' ',
  lazy = '󰒲 ',
  loaded = ' ',
  not_loaded = ' ',
  on_load = '󰡖 ',
  plugin = ' ',
  runtime = ' ',
  require = '󰢱 ',
  source = ' ',
  start = '',
  task = ' ',
  list = { ' ', ' ', ' ', ' ' },
}

icons.diagnostic = {
  error = ' ',
  warn = ' ',
  info = ' ',
  hint = ' ',
  bug = ' ',
}

icons.kind = {
  Array = '',
  Boolean = '',
  Class = '',
  Color = '',
  Constant = '',
  Constructor = '',
  Enum = '',
  EnumMember = '',
  Event = '',
  Field = '',
  File = '',
  Folder = '',
  Function = '',
  Interface = '',
  Key = '',
  Keyword = '',
  Method = '',
  Module = '',
  Namespace = '',
  Null = '',
  Number = '',
  Object = '',
  Operator = '',
  Package = '',
  Property = '',
  Reference = '',
  Snippet = '',
  String = '',
  Struct = '',
  Text = '',
  TypeParameter = '',
  Unit = '',
  Value = '',
  Variable = '',
  Component = '',
  Fragment = '󰅴',
  TypeAlias = '',
  Parameter = '',
  StaticMethod = '',
  Macro = '',
}

icons.kind_with_space = {}

for kind, icon in pairs(icons.kind) do
  icons.kind_with_space[kind] = icon .. ' '
end

return icons
