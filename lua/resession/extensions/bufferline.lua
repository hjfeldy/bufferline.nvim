local tabPages = require('bufferline.tabpages')

local M = {}

function M.on_save()
  local tabs = tabPages.get()
  local tabNames = {}
  for tabIndex, componentData in ipairs(tabs) do
    local components = componentData.component

    -- a little gross, but this will work - see tabPages.lua:render()
    local titleComponent = vim.tbl_filter(
        function(comp) return comp.attr ~= nil end,
        components
      )[1]
      tabNames[#tabNames+1] = titleComponent.text
  end
  return tabNames
end


function M.on_load(data)
  for tabIndex, tabName in ipairs(data) do
    tabPages.rename_tab(tabIndex, tabName)
  end
end

return M

