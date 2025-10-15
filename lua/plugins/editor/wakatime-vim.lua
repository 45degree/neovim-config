return {
  'wakatime/vim-wakatime',
  event = 'LazyFile',
  cond = vim.env['WAKATIME_API_KEY'] ~= nil,
  cmd = { 'WakaTimeApiKey', 'WakaTimeDebugEnable', 'WakaTimeDebugDisable', 'WakaTimeScreenRedrawDisable', 'WakaTimeToday' },
}
