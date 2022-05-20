return function(use)

    -- git标记
    use {
      "tanvirtin/vgit.nvim",
      config = function ()
        require('vgit').setup({
          settings = {
            hls = {
              GitBackgroundPrimary = 'NormalFloat',
              GitBackgroundSecondary = {
                  gui = nil,
                  fg = nil,
                  bg = nil,
                  sp = nil,
                  override = false,
              },
              GitBorder = 'LineNr',
              GitLineNr = 'LineNr',
              GitComment = 'Comment',
              GitSignsAdd = {
                  gui = nil,
                  fg = '#d7ffaf',
                  bg = nil,
                  sp = nil,
                  override = false,
              },
              GitSignsChange = {
                  gui = nil,
                  fg = '#7AA6DA',
                  bg = nil,
                  sp = nil,
                  override = false,
              },
              GitSignsDelete = {
                  gui = nil,
                  fg = '#e95678',
                  bg = nil,
                  sp = nil,
                  override = false,
              },
              GitSignsAddLn = 'DiffAdd',
              GitSignsDeleteLn = 'DiffDelete',
              GitWordAdd = {
                  gui = nil,
                  fg = nil,
                  bg = '#5d7a22',
                  sp = nil,
                  override = false,
              },
              GitWordDelete = {
                  gui = nil,
                  fg = nil,
                  bg = '#960f3d',
                  sp = nil,
                  override = false,
              },
            },
            live_blame = {
              enabled = false,
            },
            live_gutter = {
              enabled = true,
            },
            authorship_code_lens = {
              enabled = false,
            },
            screen = {
              diff_preference = 'unified',
            },
            project_diff_preview = {
              keymaps = {
                buffer_stage = 's',
                buffer_unstage = 'u',
                stage_all = 'a',
                unstage_all = 'd',
                reset_all = 'r',
              },
            },
            signs = {
              priority = 0,
              definitions = {
                GitSignsAddLn = {
                  linehl = 'GitSignsAddLn',
                  texthl = nil,
                  numhl = nil,
                  icon = nil,
                  text = '',
                },
                GitSignsDeleteLn = {
                  linehl = 'GitSignsDeleteLn',
                  texthl = nil,
                  numhl = nil,
                  icon = nil,
                  text = '',
                },
                GitSignsAdd = {
                  texthl = 'GitSignsAdd',
                  numhl = nil,
                  icon = nil,
                  linehl = nil,
                  text = '┃',
                },
                GitSignsDelete = {
                  texthl = 'GitSignsDelete',
                  numhl = nil,
                  icon = nil,
                  linehl = nil,
                  text = '┃',
                },
                GitSignsChange = {
                  texthl = 'GitSignsChange',
                  numhl = nil,
                  icon = nil,
                  linehl = nil,
                  text = '┃',
                },
              },
              usage = {
                screen = {
                  add = 'GitSignsAddLn',
                  remove = 'GitSignsDeleteLn',
                },
                main = {
                  add = 'GitSignsAdd',
                  remove = 'GitSignsDelete',
                  change = 'GitSignsChange',
                },
              },
            },
            symbols = {
                void = '⣿',
            },
          }
        })
      end
    }

    -- 内置git命令
    use 'tpope/vim-fugitive'

    -- git log图
    use 'junegunn/gv.vim'
end
