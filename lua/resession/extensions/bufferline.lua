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


function M.on_load(tabNames)

  -- Start from the *current* tab index, and wraparound
  local tabIndex = vim.api.nvim_win_get_tabpage(0)
  for _, _ in ipairs(tabNames) do
    local tabName = tabNames[tabIndex]
    tabPages.rename_tab(tabIndex, tabName)
    tabIndex = tabIndex+1
    if tabIndex > #tabNames then tabIndex = 1 end
    vim.cmd('tabnext')
  end
end

return M

