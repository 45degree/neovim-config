---@diagnostic disable: param-type-mismatch
function string:split(delimiter)
  local input = tostring(self)
  delimiter = tostring(delimiter)

  if delimiter == '' then return false end

  local pos, arr = 0, {}
  for st, sp in function() return string.find(input, delimiter, pos, true) end do
    table.insert(arr, string.sub(input, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(input, pos))
  return arr
end

function string:trim() return self:gsub('^%s*(.-)%s*$', '%1') end
