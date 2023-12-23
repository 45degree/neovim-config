-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath('cache') .. '/nightfox',
    compile_file_suffix = '_compiled', -- Compiled file suffix
    transparent = false,               -- Disable setting background
    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,              -- Non focused panes set to alternative background
    module_default = true,             -- Default enable value for modules
    colorblind = {
      enable = false,                  -- Enable colorblind support
      simulate_only = false,           -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,                    -- Severity [0,1] for protan (red)
        deutan = 0,                    -- Severity [0,1] for deutan (green)
        tritan = 0,                    -- Severity [0,1] for tritan (blue)
      },
    },
    styles = {
      -- Style to be applied to different syntax groups
      comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
      conditionals = 'italic',
      constants = 'NONE',
      functions = 'bold',
      keywords = 'bold,italic',
      numbers = 'NONE',
      operators = 'NONE',
      strings = 'NONE',
      types = 'NONE',
      variables = 'NONE',
    },
    inverse = {
      -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = { -- List of various plugins and additional options
      barbar = true,
      gitsigns = true,
      indent_blankline = true,
      navic = true,
      neogit = true,
      neotree = true,
      notify = true,
      diagnostic = {
        -- This is linked to so much that is needs to be enabled. This is here primarily
        -- for the extra options that can be added with modules
        enable = true,
        background = true,
      },
      native_lsp = {
        enable = true,
        background = true,
      },
      treesitter = true,
      lsp_semantic_tokens = true,
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})
