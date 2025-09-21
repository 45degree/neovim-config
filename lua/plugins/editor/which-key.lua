local choose_win = function()
  local picker = require('window-picker')
  local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end

local function toggle_profile()
  local prof = require('profile')
  if prof.is_recording() then
    prof.stop()
    vim.ui.input({ prompt = 'Save profile to:', completion = 'file', default = 'profile.json' }, function(filename)
      if filename then
        prof.export(filename)
        vim.notify(string.format('Wrote %s', filename))
      end
    end)
  else
    prof.start('*')
  end
end

local register = {
  -- file
  { '<leader>f', group = 'file' },
  { '<leader>fs', '<cmd>w<cr>', desc = 'Save current file' },
  { '<leader>fS', '<cmd>wa<cr>', desc = 'Save all file' },
  { '<leader>fc', '<cmd>e $MYVIMRC<cr>', desc = 'open neovim config file' },

  -- search
  { '<leader>s', group = 'search' },
  { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = 'search file in current directory' },
  { '<leader>sa', function() require('telescope').extensions.live_grep_args.live_grep_args() end, desc = 'search content in current directory' },
  { '<leader>sg', '<cmd>Telescope git_files<cr>', desc = 'search file in git project' },
  { '<leader>sc', '<cmd>Telescope colorscheme<cr>', desc = 'search colorscheme' },
  { '<leader>sh', '<cmd>Telescope oldfiles<cr>', desc = 'search history' },
  { '<leader>sp', '<cmd>SessionManager load_session<cr>', desc = 'load session' },
  { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'search marks' },
  { '<leader>sb', '<cmd>Telescope buffers<cr>', desc = 'search all buffers' },
  { '<leader>sr', '<cmd>Spectre<cr>', desc = 'search and replace' },

  -- code
  { '<leader>c', group = 'code' },
  { '<leader>cf', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end, desc = 'format the code' },
  { '<leader>cT', '<cmd>Trouble diagnostics<cr>', desc = 'open code diagnostics' },
  { '<leader>ch', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = 'toggle inlay hints' },

  -- code debug
  { '<leader>cd', group = 'debug' },
  { '<leader>cd=', function() require('dapui').open({ reset = true }) end, desc = 'balance debug window' },
  { '<leader>cdc', function() require('dap').terminate() end, desc = 'terninate debug' },
  { '<leader>cdw', function() require('dapui').toggle() end, desc = 'toggle debug windows' },

  -- git
  { '<leader>g', group = 'git' },
  { '<leader>gN', '<cmd>Gitsigns prev_hunk<cr>', desc = 'jump to the previous git hunk' },
  { '<leader>gc', '<cmd>Gitsigns preview_hunk<cr>', desc = 'show the current line git hunk' },
  { '<leader>gd', '<cmd>Gitsigns diffthis<cr>', desc = 'show current file changes' },
  { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'show current file change history' },
  { '<leader>gn', '<cmd>Gitsigns next_hunk<cr>', desc = 'jump to the next git hunk' },
  { '<leader>gp', '<cmd>DiffviewOpen<cr>', desc = 'show Git project changes' },
  { '<leader>grh', '<cmd>Gitsigns reset_hunk<cr>', desc = 'reset git hunk' },
  { '<leader>gsh', '<cmd>Gitsigns stage_hunk<cr>', desc = 'stage git hunk' },
  { '<leader>guh', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = 'undo git hunk' },

  -- filesystem and outlines
  { '<leader>t', '<cmd>Neotree toggle<cr>', desc = 'toggle filesystem', icon = '󰙅' },
  { '<leader>T', '<cmd>Outline<cr>', desc = 'toggle outlines', icon = '󱏒' },

  -- windows
  { '<leader>w', group = 'windows' },
  { '<leader>w=', '<C-W>=', desc = 'balance windows' },
  { '<leader>wH', '<C-W>5<', desc = 'extend window left' },
  { '<leader>wJ', '<cmd>resize +5<cr>', desc = 'expand window down' },
  { '<leader>wK', '<cmd>resize -5<cr>', desc = 'expand window upwards' },
  { '<leader>wL', '<C-W>5>', desc = 'extend window right' },
  { '<leader>wc', choose_win, desc = 'choose window' },
  { '<leader>wd', '<C-W>c', desc = 'delete current window' },
  { '<leader>wh', '<C-W>h', desc = 'move cursor to the left window' },
  { '<leader>wj', '<C-W>j', desc = 'move cursor to the bottom window' },
  { '<leader>wk', '<C-W>k', desc = 'move cursor to the upwards window' },
  { '<leader>wl', '<C-W>l', desc = 'move cursor to the right window' },
  { '<leader>ws', '<C-W>s', desc = 'split window' },
  { '<leader>wv', '<C-W>v', desc = 'vertical split window' },

  -- buffer
  { '<leader>b', group = 'buffer' },
  { '<leader>bd', group = 'delete buffer' },

  -- extensions
  { '<leader>e', group = 'extension', icon = '' },
  { '<leader>ep', group = 'profile', icon = '󰈸' },
  { '<leader>epb', '<cmd>lua Snacks.profiler.start()<cr>', desc = 'begin profile', icon = '󰈸' },
  { '<leader>epe', '<cmd>lua Snacks.profiler.stop()<cr>', desc = 'end profile', icon = '󰈸' },
  { '<leader>ept', '<cmd>lua Snacks.profiler.toggle()<cr>', desc = 'toggle profile', icon = '󰈸' },

  -- localleader
  { '<localleader>', group = 'local keymap', icon = '' },
}

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = { preset = 'modern' },
  config = function(_, opts)
    require('which-key').setup(opts)

    local wk = require('which-key')
    wk.add(register)
  end,
}
