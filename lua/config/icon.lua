local icons = {}

icons.layout = {
  list = '•',
  tab = '→',
  wrap = '↪',
}

icons.gitsigns = {
  -- Change type
  added = ' ', -- or "✚", but this is redundant info if you use git_status_colors on the name
  modified = ' ', -- or "", but this is redundant info if you use git_status_colors on the name
  deleted = ' ', -- this can only be used in the git_status source
  renamed = ' ', -- this can only be used in the git_status source
  -- Status type
  untracked = ' ',
  ignored = ' ',
  unstaged = ' ',
  staged = ' ',
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
  task = '✔ ',
  list = { ' ', ' ', ' ', ' ' },
}

icons.diagnostic = {
  error = ' ',
  warn = ' ',
  info = ' ',
  hint = ' ',
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
}

return icons
