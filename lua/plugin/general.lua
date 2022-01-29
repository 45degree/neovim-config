return function(use)

  use 'liuchengxu/vim-which-key'

  -- sudo保存
  use {
      'lambdalisue/suda.vim',
      config = function()
          vim.g.suda_smart_edit = 1
      end
  }

  -- 自动匹配括号
  use 'jiangmiao/auto-pairs'

  -- jk加速
  use {
    'rhysd/accelerated-jk',
    config = function()
        vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
        vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
    end
  }

  -- 模糊搜索
  use {
      'liuchengxu/vim-clap',
      run = function()
          vim.call('clap#installer#download_binary')
      end,
      config = function()
          vim.g.clap_theme = 'material_design_dark'
      end
  }

  -- 成对编辑
  use 'tpope/vim-surround'

  -- 快速选中
  use 'gcmt/wildfire.vim'

  -- 终端
  use 'skywind3000/vim-terminal-help'

  -- markdown
  use {
      'iamcco/markdown-preview.nvim',
      run = function()
          vim.call('mkdp#util#install')
      end
  }

  -- 翻译
  use {
      'voldikss/vim-translator',
      config = function()
        vim.g.translator_default_engines = {'haici', 'bing'}
      end

  }


end
