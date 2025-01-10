return {
  'yetone/avante.nvim',
  lazy = true,
  cmd = {
    'AvanteAsk',
    'AvanteBuild',
    'AvanteChat',
    'AvanteEdit',
    'AvanteFocus',
    'AvanteRefresh',
    'AvanteSwitchProvider',
    'AvanteShowRepoMap',
    'AvanteToggle',
  },
  build = ':AvanteBuild',
  version = '*',
  opts = {
    -- add any opts here
    provider = 'kimi', -- You can then change this provider here
    vendors = {
      kimi = {
        __inherited_from = 'openai',
        api_key_name = 'KIMI_API_KEY',
        endpoint = 'https://api.moonshot.cn/v1',
        model = 'moonshot-v1-8k',
      },
    },
  },
}
