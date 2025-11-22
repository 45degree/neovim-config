local icons = require('icons')

local function open_with_system_application(state) require('lazy.util').open(state.tree:get_node().path, { system = true }) end

return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  init = function()
    if vim.fn.argc() == 1 then
      ---@diagnostic disable-next-line: param-type-mismatch
      local stat = vim.uv.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then require('neo-tree') end
    end
  end,
  opts = {
    event_handlers = {
      {
        event = 'neo_tree_window_after_close',
        handler = function()
          if package.loaded['dapui'] then
            local dapui_windows = require('dapui.windows')
            if #dapui_windows.layouts > 0 and dapui_windows.layouts[1]:is_open() then require('dapui').open({ reset = true }) end
          end
        end,
      },
      {
        event = 'neo_tree_popup_input_ready',
        handler = function(args)
          -- enter input popup with normal mode by default.
          vim.keymap.set('i', '<esc>', vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
        end,
      },
    },
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = require('config').border,
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
        { source = 'git_status', display_name = ' 󰊢 Git ' },
        -- { source = 'document_symbols', display_name = '  Outline ' },
      },
      content_layout = 'center',
    },
    default_component_configs = {
      diagnostics = { symbols = icons.diagnostic },
      indent = { with_markers = false, with_expanders = true },
      icon = {
        provider = function(icon, node, state)
          local text, hl
          local mini_icons = require('mini.icons')
          if node.type == 'file' then -- if it's a file, set the text/hl
            text, hl = mini_icons.get('file', node.name)
          elseif node.type == 'directory' then -- get directory icons
            text, hl = mini_icons.get('directory', node.name)
            -- only set the icon text if it is not expanded
            if node:is_expanded() then text = nil end
          end

          -- set the icon text/highlight only if it exists
          if text then icon.text = text end
          if hl then icon.highlight = hl end
        end,
      },
      git_status = { symbols = icons.gitsigns },
    },
    window = {
      mappings = {
        ['R'] = 'refresh',
        ['?'] = 'show_help',
        ['<'] = 'prev_source',
        ['>'] = 'next_source',
      },
      fuzzy_finder_mappings = {
        ['<esc>'] = 'noop', -- use normal mode
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
          ['O'] = { open_with_system_application, desc = 'Open with system application' },
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
      follow_current_file = { enabled = true }
    },
    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['<2-LeftMouse>'] = 'open_with_window_picker',
          ['<cr>'] = 'open_with_window_picker',
          ['O'] = { open_with_system_application, desc = 'Open with system application' },
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
        root = {
          { 'indent' },
          { 'icon', default = '' },
          { 'name', zindex = 10 },
        },
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
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)

    local function clear_neotree_git_highlight_bg()
      local function get_highlight_fg(name)
        local group = vim.api.nvim_get_hl(0, { name = name })
        while group.link do
          group = vim.api.nvim_get_hl(0, { name = group.link })
        end
        return group.fg
      end

      vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', { fg = get_highlight_fg('NeoTreeGitAdded') })
      vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', { fg = get_highlight_fg('NeoTreeGitConflict') })
      vim.api.nvim_set_hl(0, 'NeoTreeGitDeleted', { fg = get_highlight_fg('NeoTreeGitDeleted') })
      vim.api.nvim_set_hl(0, 'NeoTreeGitIgnored', { fg = get_highlight_fg('NeoTreeGitIgnored') })
      vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = get_highlight_fg('NeoTreeGitModified') })
      vim.api.nvim_set_hl(0, 'NeoTreeGitUnstaged', { fg = get_highlight_fg('NeoTreeGitUnstaged') })
      vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = get_highlight_fg('NeoTreeGitUntracked') })
      vim.api.nvim_set_hl(0, 'NeoTreeGitStaged', { fg = get_highlight_fg('NeoTreeGitStaged') })
    end

    -- Neotree's file git state should not have background colors
    clear_neotree_git_highlight_bg()
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = clear_neotree_git_highlight_bg,
    })
    vim.api.nvim_create_autocmd('OptionSet', {
      pattern = 'background',
      callback = clear_neotree_git_highlight_bg,
    })
  end,
}
