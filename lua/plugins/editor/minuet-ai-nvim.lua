return {
  'milanglacier/minuet-ai.nvim',
  event = 'InsertEnter',
  cond = require('config').edit_prediction_provider.name == 'minuet',
  opts = {
    request_timeout = 3,
    virtualtext = {
      auto_trigger_ft = { '*' },
      keymap = {
        accept = '<M-l>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
    },
  },
  config = function(_, opts)
    local provider = require('config').edit_prediction_provider.opts
    if provider.name == 'deepseek' then
      opts.provider = 'openai_fim_compatible'
      opts.provider_options = {
        openai_fim_compatible = {
          api_key = function() return provider.api_key end,
          name = 'deepseek',
          model = 'deepseek-flash',
          end_point = 'https://api.deepseek.com/beta/completions',
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      }
    end

    require('minuet').setup(opts)
  end,
}
