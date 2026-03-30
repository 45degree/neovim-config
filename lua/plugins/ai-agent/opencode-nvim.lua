---@diagnostic disable: missing-fields

local config = require('config')

local editor_keymap = {
  ['<leader>at'] = { 'toggle', desc = 'Toggle opencode' },
  ['<leader>aa'] = { 'quick_chat', mode = { 'n', 'x' }, desc = 'Quick chat' },
  ['<leader>as'] = { 'select_session', mode = { 'n', 'x' }, desc = 'Select session' },
  ['<leader>av'] = { 'add_visual_selection', mode = { 'v' }, desc = 'Add visual selection' },
  ['<leader>aV'] = { 'add_visual_selection_inline', mode = { 'v' }, desc = 'Add visual selection as code' },
}

local input_window_keymap = {
  ['<S-cr>'] = { 'submit_input_prompt', desc = 'Submit input prompt', mode = { 'n' } },
  ['q'] = { 'close', mode = { 'n' }, desc = 'Close Opencode Window' },
  ['<C-c>'] = { 'cancel', desc = 'Cancel Agent Response' },
  ['~'] = { 'mention_file', mode = 'i' },
  ['@'] = { 'mention', mode = 'i' },
  ['/'] = { 'slash_commands', mode = 'i' },
  ['#'] = { 'context_items', mode = 'i' },
  ['<M-v>'] = { 'paste_image', mode = 'i' },
  ['<C-i>'] = { 'focus_input', mode = { 'n', 'i' } },
  ['<tab>'] = { 'switch_mode', mode = { 'n' } },
  ['<up>'] = { 'prev_prompt_history', mode = { 'n', 'i' } },
  ['<down>'] = { 'next_prompt_history', mode = { 'n', 'i' } },
  ['<M-r>'] = { 'cycle_variant', mode = { 'n', 'i' } },
}

local output_window_keymap = {
  ['q'] = { 'close', mode = { 'n' }, desc = 'Close Opencode Window' },
  ['<C-c>'] = { 'cancel', desc = 'Cancel Agent Response' },
  [']]'] = { 'next_message' },
  ['[['] = { 'prev_message' },
  ['<tab>'] = { 'switch_mode', mode = { 'n' } },
  ['i'] = { 'focus_input', 'n' },
  ['<M-r>'] = { 'cycle_variant', mode = { 'n' } },
  ['<leader>aS'] = { 'select_child_session', desc = 'Select Child Session' },
}

return {
  'sudo-tee/opencode.nvim',
  cond = require('config').ai_code_agent.name == 'opencode',
  lazy = true,
  dependencies = 'OXY2DEV/markview.nvim',
  ---@type OpencodeConfig
  opts = {
    keymap = {
      editor = editor_keymap,
      input_window = input_window_keymap,
      output_window = output_window_keymap,
    },
    context = { current_file = { enabled = false } },
    quick_chat = { default_agent = 'build', default_model = config.ai_code_agent.opts.quick_chat_model },
  },
  keys = function()
    local result = {}
    for k, v in pairs(editor_keymap) do
      if type(v) ~= 'table' then goto continue end

      local item = { k, function() require('opencode.api')[v[1]]() end }
      for opt, value in pairs(v) do
        if type(opt) == 'string' then item[opt] = value end
      end
      table.insert(result, item)

      ::continue::
    end

    return result
  end,
  config = function(_, opts)
    -- override default keymaps
    local default_editor_keymap = require('opencode.config').keymap.editor
    local default_input_window_keymap = require('opencode.config').keymap.input_window
    local default_output_window_keymap = require('opencode.config').keymap.output_window

    opts.keymap = opts.keymap or {}

    opts.keymap.editor = opts.keymap.editor or {}
    for k, _ in pairs(default_editor_keymap) do
      if not opts.keymap.editor[k] then opts.keymap.editor[k] = false end
    end

    opts.keymap.input_window = opts.keymap.input_window or {}
    for k, _ in pairs(default_input_window_keymap) do
      if not opts.keymap.input_window[k] then opts.keymap.input_window[k] = false end
    end

    opts.keymap.output_window = opts.keymap.output_window or {}
    for k, _ in pairs(default_output_window_keymap) do
      if not opts.keymap.output_window[k] then opts.keymap.output_window[k] = false end
    end

    require('opencode').setup(opts)

    vim.api.nvim_create_autocmd('BufWinEnter', {
      pattern = '*',
      callback = function(ev)
        if string.match(vim.bo[ev.buf].filetype, 'opencode_*') then vim.opt_local.foldenable = false end
      end,
    })
  end,
}
