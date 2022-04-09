local actions = require('telescope.actions')
local actions_state = require('telescope.actions.state')
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local res = {}

local function getAllTemplate()
    local templatefiles = vim.fn.globpath(vim.fn.stdpath('config')..'/vimspector_json', '*')
    templatefiles = vim.fn.split(templatefiles)
    return templatefiles;
end

res.GenTemplate = function()
    local files = getAllTemplate();
    local opts = {}
    pickers.new(opts, {prompt_title = "colors",
        finder = finders.new_table {
            results = files,
        },
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = actions_state.get_selected_entry()
                local content = vim.fn.readfile(selection[1])

                local buffer = vim.api.nvim_create_buf(true, false)
                vim.api.nvim_buf_set_name(buffer, '.vimspector.json')
                vim.api.nvim_buf_set_lines(buffer, 0, #content, false, content)
                vim.cmd(':b '..buffer)
            end)
            return true
        end,
        previewer = conf.file_previewer(opts),
        sorter = conf.generic_sorter(opts),
    }):find()
end

return res;
