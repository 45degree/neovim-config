return function(use)
    -- 颜色主题
    use 'kaicataldo/material.vim'
    use "rebelot/kanagawa.nvim"
    use 'morhetz/gruvbox'
    use 'SpaceVim/SpaceVim-theme'
    use 'sainnhe/edge'
    use 'ajmwagar/vim-deus'
    use 'folke/tokyonight.nvim'
    use 'sainnhe/everforest'
    use 'mhartington/oceanic-next'

    -- 图标
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'

    -- 开始面板
    use {
        'glepnir/dashboard-nvim',
        config = function()
            vim.g.dashboard_default_executive = 'clap'
            vim.g.dashboard_custom_shortcut = {
                ['last_session']       = 'SPC s l',
                ['find_history']       = 'SPC f h',
                ['find_file']          = 'SPC s f',
                ['new_file']           = 'SPC f a',
                ['change_colorscheme'] = 'SPC s c',
                ['find_word']          = 'SPC f a',
                ['book_marks']         = 'SPC f b',
            }
            vim.g.dashboard_custom_header = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }
        end
    }

    use {
        "SmiteshP/nvim-gps",
        config = function ()
            -- Default config
            require("nvim-gps").setup()
        end
    }

    -- 状态栏
    use {
        'glepnir/galaxyline.nvim',
        after = "nvim-gps",

        config = function()
            local gl = require('galaxyline')
            local colors = require('galaxyline.theme').default
            local condition = require('galaxyline.condition')
            local gps = require("nvim-gps");

            local gls = gl.section
            gl.short_line_list = {'NvimTree','vista','dbui','packer', 'coc-explorer'}

            gls.left[1] = {
                RainbowRed = {
                    provider = function() return '▊ ' end,
                    highlight = {colors.blue,colors.bg}
                },
            }

            gls.left[2] = {
                ViMode = {
                    provider = function()
                    -- auto change color according the vim mode
                    local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
                                      [''] = colors.blue,V=colors.blue,
                                      c = colors.magenta,no = colors.red,s = colors.orange,
                                      S=colors.orange,[''] = colors.orange,
                                      ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                                      cv = colors.red,ce=colors.red, r = colors.cyan,
                                      rm = colors.cyan, ['r?'] = colors.cyan,
                                      ['!']  = colors.red,t = colors.red}
                    vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()] ..' guibg='..colors.bg)
                    return '  '
                end,
              },
            }

            gls.left[3] ={
                FileIcon = {
                    provider = 'FileIcon',
                    condition = condition.buffer_not_empty,
                    highlight = {
                        require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg
                    },
                },
            }

            gls.left[4] = {
                FileName = {
                    provider = 'FileName',
                    condition = condition.buffer_not_empty,
                    highlight = {colors.fg,colors.bg,'bold'},
                    separator = ' ',
                    separator_highlight = {
                        'NONE',
                        colors.bg
                    },
                }
            }

            gls.left[5] = {
                GitIcon = {
                    provider = function() return '  ' end,
                    condition = condition.check_git_workspace,
                    separator = ' ',
                    separator_highlight = {
                        'NONE',
                        colors.bg
                    },
                    highlight = {
                        colors.violet,
                        colors.bg,
                        'bold'
                    },
                }
            }

            gls.left[6] = {
                GitBranch = {
                    provider = 'GitBranch',
                    condition = condition.check_git_workspace,
                    highlight = {colors.violet,colors.bg,'bold'},
                    separator = ' ',
                    separator_highlight = { 'NONE' ,colors.bg},
                }
            }

            gls.left[7] = {
              DiffAdd = {
                provider = 'DiffAdd',
                condition = condition.hide_in_width,
                icon = '   ',
                highlight = {colors.green,colors.bg},
              }
            }

            gls.left[8] = {
              DiffModified = {
                provider = 'DiffModified',
                condition = condition.hide_in_width,
                icon = ' 柳',
                highlight = {colors.orange,colors.bg},
              }
            }

            gls.left[9] = {
              DiffRemove = {
                provider = 'DiffRemove',
                condition = condition.hide_in_width,
                icon = '  ',
                highlight = {colors.red,colors.bg},
              }
            }

            gls.left[10] = {
              Space = {
                provider = function () return ' ' end,
                highlight = {'None',colors.bg},
              }
            }

            gls.left[11] = {
              DiagnosticError = {
                provider = 'DiagnosticError',
                icon = '  ',
                separator = ' ',
                separator_highlight = { 'NONE' ,colors.bg},
                highlight = {colors.red,colors.bg}
              }
            }
            gls.left[12] = {
              DiagnosticWarn = {
                provider = 'DiagnosticWarn',
                icon = '  ',
                highlight = {colors.yellow,colors.bg},
              }
            }

            gls.left[13] = {
              DiagnosticHint = {
                provider = 'DiagnosticHint',
                icon = '  ',
                separator = ' ',
                separator_highlight = { 'NONE' ,colors.bg},
                highlight = {colors.cyan,colors.bg},
              }
            }

            gls.left[14] = {
              DiagnosticInfo = {
                provider = 'DiagnosticInfo',
                icon = '  ',
                highlight = {colors.blue,colors.bg},
              }
            }

            gls.left[15] = {
                nvimGPS = {
                    provider = function()
                        return gps.get_location()
                    end,
                    condition = function()
                        return gps.is_available()
                    end,
                    highlight = {colors.fg,colors.bg},
                }
            }

            gls.right[1] = {
              LineInfo = {
                provider = 'LineColumn',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.fg,colors.bg},
              },
            }

            gls.right[2] = {
              FileSize = {
                provider = 'FileSize',
                separator = '| ',
                condition = condition.buffer_not_empty,
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.fg,colors.bg}
              }
            }

            gls.right[3] = {
              FileEncode = {
                provider = 'FileEncode',
                condition = condition.hide_in_width,
                separator = '|',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.green,colors.bg,'bold'}
              }
            }

            gls.right[4] = {
              FileFormat = {
                provider = 'FileFormat',
                condition = condition.hide_in_width,
                separator = ' ',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.green,colors.bg,'bold'}
              }
            }

            gls.right[5] = {
              PerCent = {
                provider = 'LinePercent',
                separator = ' |',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.fg,colors.bg,'bold'},
              }
            }

            gls.right[6] = {
              RainbowBlue = {
                provider = function() return ' ▊' end,
                highlight = {colors.blue,colors.bg}
              },
            }

            gls.short_line_left[1] = {
              BufferType = {
                provider = function() return '▊ ' end,
                highlight = {colors.blue,colors.bg}
              }
            }

            gls.short_line_left[2] = {
              SFileName = {
                provider =  'SFileName',
                condition = condition.buffer_not_empty,
                highlight = {colors.fg,colors.bg,'bold'}
              }
            }

            gls.short_line_right[1] = {
              BufferIcon = {
                provider = function() return ' ▊' end,
                highlight = {colors.blue,colors.bg}
              }
            }
        end
    }

    -- tab栏
    use 'romgrk/barbar.nvim'

    -- 缩进线
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.opt.list = true
            vim.cmd [[highlight IndentBlanklineIndent1 guifg=#666666 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent2 guifg=#666666 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent3 guifg=#666666 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent4 guifg=#666666 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent5 guifg=#666666 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent6 guifg=#666666 gui=nocombine]]

            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
                buftype_exclude = { "terminal", "nofile", "prompt"},
                filetype_exclude = { "dashboard", "coc-explorer"},
                char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3",
                    "IndentBlanklineIndent4",
                    "IndentBlanklineIndent5",
                    "IndentBlanklineIndent6",
                },
            }
        end
    }
end
