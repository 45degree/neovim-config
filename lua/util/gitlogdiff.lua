-- Pick commits from git log (via snacks.nvim picker) and open their combined
-- diff in diffview.nvim.
--
-- Because git/diffview can only diff a *contiguous* range (two endpoints), the
-- picker enforces a contiguous selection: what you see highlighted is exactly
-- what gets diffed. Jumping/disjoint selections are not possible by design.
--
-- Interaction:
--   <Tab>            set anchor (first press) / extend selection to cursor
--   <S-Tab>          clear selection and reset anchor
--   type to filter   fuzzy match commits
--   <CR>             open the diff for the selected range in Diffview
--
-- Diff semantics (mirrors gitlogdiff.nvim):
--   1 commit selected   -> <hash>^..<hash>     (that commit against its parent)
--   2+ commits selected -> <oldest>^..<newest> (contiguous range)
--   nothing selected    -> commit under cursor (^.. its parent)

local M = {}

M.config = {
  -- forwarded to Snacks.picker.git_log as additional git args
  max_count = 300,
}

function M.setup(opts) M.config = vim.tbl_deep_extend('force', M.config, opts or {}) end

-- Build a diffview range from an ordered list of commit hashes.
-- Items come in picker order (top = newest), so hashes[1] is the newest and
-- hashes[#] is the oldest.
local function range_from_hashes(hashes)
  if #hashes == 1 then return hashes[1] .. '^..' .. hashes[1] end
  local newest = hashes[1]
  local oldest = hashes[#hashes]
  return oldest .. '^..' .. newest
end

local function on_confirm(picker)
  local items = picker:selected({ fallback = true })
  picker:close()

  local hashes = {}
  for _, item in ipairs(items) do
    if item.commit then hashes[#hashes + 1] = item.commit end
  end

  if #hashes == 0 then
    vim.notify('No commits selected', vim.log.levels.INFO)
    return
  end

  vim.cmd('DiffviewOpen ' .. range_from_hashes(hashes))
end

function M.open()
  local ok, Snacks = pcall(require, 'snacks')
  if not ok then
    vim.notify('snacks.nvim is required for gitlogdiff', vim.log.levels.ERROR)
    return
  end

  -- Anchor index (sorted/list position) for the contiguous selection.
  -- Reset every time the picker opens.
  local anchor = nil

  -- Select every list item between `anchor` and the cursor (inclusive),
  -- guaranteeing a contiguous selection.
  local function extend_selection(picker)
    local list = picker.list
    local cur = list.cursor
    if not cur then return end
    if not anchor then anchor = cur end
    local lo, hi = math.min(anchor, cur), math.max(anchor, cur)
    local items = {}
    for i = lo, hi do
      local it = list:get(i)
      if it then items[#items + 1] = it end
    end
    list:set_selected(items)
  end

  local function clear_selection(picker)
    anchor = nil
    picker.list:set_selected({})
  end

  Snacks.picker.git_log({
    -- cmd_args go *after* the `log` subcommand
    cmd_args = { '--max-count=' .. (tonumber(M.config.max_count) or 300) },
    title = 'Git Commits  (<Tab> anchor/extend · <S-Tab> clear · <CR> diff)',
    confirm = on_confirm,
    actions = {
      gld_extend = extend_selection,
      gld_clear = clear_selection,
    },
    win = {
      input = {
        keys = {
          ['<Tab>'] = { 'gld_extend', mode = { 'n', 'i' } },
          ['<S-Tab>'] = { 'gld_clear', mode = { 'n', 'i' } },
        },
      },
      list = {
        keys = {
          ['<Tab>'] = 'gld_extend',
          ['<S-Tab>'] = 'gld_clear',
        },
      },
    },
  })
end

return M
