local icons = require('icons')

local opts = {
  event_handlers = {
    {
      event = 'neo_tree_window_after_close',
      handler = function()
        if require('dap').session() then
          require('dapui').open({ reset = true })
        end
      end,
    },
    {
      event = 'neo_tree_popup_input_ready',
      handler = function()
        -- enter input popup with normal mode by default.
        vim.cmd('stopinsert')
      end,
    },
  },
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = 'rounded',
  enable_git_status = true,
  enable_diagnostics = true,
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  sort_function = nil, -- use a custom function for sorting files and directories in the tree
  sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
  source_selector = {
    winbar = true,
    statusline = false,
    sources = {
      { source = 'filesystem', display_name = ' 󰉓 Files ' },
      { source = 'buffers', display_name = '  Buffer ' },
      { source = 'git_status', display_name = ' 󰊢 Git ' },
      { source = 'document_symbols', display_name = ' Symbols ' },
    },
  },
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    diagnostics = { symbols = icons.diagnostic },
    indent = { with_markers = false, with_expanders = true },
    icon = { default = '' },
    git_status = { symbols = icons.gitsigns },
  },
  window = {
    position = 'left',
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['R'] = 'refresh',
      ['?'] = 'show_help',
      ['<'] = 'prev_source',
      ['>'] = 'next_source',
    },
  },
  filesystem = {
    cwd_target = {
      sidebar = 'global', -- sidebar is when position = left or right
    },
    filtered_items = {
      always_show = { '.gitignore', '.gitmodules', '.gitkeep', '.gitignore', '.vscode', '.clang-format', '.clang-tidy' },
    },
    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ['<2-LeftMouse>'] = 'open_with_window_picker',
        ['<cr>'] = 'open_with_window_picker',
        ['a'] = { 'add', config = { show_path = 'none' } },
        ['A'] = 'add_directory',
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['c'] = { 'copy', config = { show_path = 'absolute' } },
        ['m'] = 'move',
        ['<bs>'] = 'navigate_up',
        ['.'] = 'toggle_hidden',
        ['/'] = 'fuzzy_finder',
        ['D'] = 'fuzzy_finder_directory',
        ['f'] = 'filter_on_submit',
        ['<c-x>'] = 'clear_filter',
        ['[g'] = 'prev_git_modified',
        [']g'] = 'next_git_modified',
      },
    },
  },
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    }, -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    group_empty_dirs = true, -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = {
        ['bd'] = 'buffer_delete',
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
      },
    },
  },
  git_status = {
    window = {
      position = 'float',
      mappings = {
        ['A'] = 'git_add_all',
        ['gu'] = 'git_unstage_file',
        ['ga'] = 'git_add_file',
        ['gr'] = 'git_revert_file',
        ['gc'] = 'git_commit',
        ['gp'] = 'git_push',
        ['gg'] = 'git_commit_and_push',
      },
    },
  },
  document_symbols = {
    follow_cursor = true,
    renderers = {
      symbol = {
        { 'indent', with_expanders = true },
        { 'kind_icon', default = '?' },
        { 'container', content = { { 'name', zindex = 10 } } },
      },
    },
    window = {
      mappings = {
        ['<cr>'] = 'toggle_node',
        ['o'] = 'jump_to_symbol',
      },
    },
    kinds = {
      Unknown = { icon = '?', hl = '' },
      Root = { icon = '', hl = 'NeoTreeRootName' },
      File = { icon = icons.kind.File, hl = 'Tag' },
      Module = { icon = icons.kind.Module, hl = 'Exception' },
      Namespace = { icon = icons.kind.Namespace, hl = 'Include' },
      Package = { icon = icons.kind.Package, hl = 'Label' },
      Class = { icon = icons.kind.Class, hl = 'Include' },
      Method = { icon = icons.kind.Method, hl = 'Function' },
      Property = { icon = icons.kind.Property, hl = '@property' },
      Field = { icon = icons.kind.Field, hl = '@field' },
      Constructor = { icon = icons.kind.Constructor, hl = '@constructor' },
      Enum = { icon = icons.kind.Enum, hl = '@number' },
      Interface = { icon = icons.kind.Interface, hl = 'Type' },
      Function = { icon = icons.kind.Function, hl = 'Function' },
      Variable = { icon = icons.kind.Variable, hl = '@variable' },
      Constant = { icon = icons.kind.Constant, hl = 'Constant' },
      String = { icon = icons.kind.String, hl = 'String' },
      Number = { icon = icons.kind.Number, hl = 'Number' },
      Boolean = { icon = icons.kind.Boolean, hl = 'Boolean' },
      Array = { icon = icons.kind.Array, hl = 'Type' },
      Object = { icon = icons.kind.Object, hl = 'Type' },
      Key = { icon = icons.kind.Key, hl = '' },
      Null = { icon = icons.kind.Null, hl = 'Constant' },
      EnumMember = { icon = icons.kind.EnumMember, hl = 'Number' },
      Struct = { icon = icons.kind.Struct, hl = 'Type' },
      Event = { icon = icons.kind.Event, hl = 'Constant' },
      Operator = { icon = icons.kind.Operator, hl = 'Operator' },
      TypeParameter = { icon = icons.kind.TypeParameter, hl = 'Type' },
    },
  },
}

return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    's1n7ax/nvim-window-picker',
  },
  init = function()
    if vim.fn.argc() == 1 then
      ---@diagnostic disable-next-line: param-type-mismatch
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require('neo-tree')
      end
    end
  end,
  config = function()
    require('neo-tree').setup(opts)
    vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
  end,
}
