local Popup = require("nui.popup")
local Input = require("nui.input")
local Layout = require("nui.layout")
local utils = require("forgit.utils")

local M = {}

function M.render()
  local added_files = utils.get_git_added_files()

  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = "Files to be Committed",
        top_align = "center",
      }
    },
    position = "50%",
    size = {
      width = "70%",
      height = "50%",
    },
  })

  local input_popup_options = {
    position = {
      row = "90%",
      col = "52%"
    },
    size = "70%",
    border = {
      style = "rounded",
      text = {
        top = "Type your commit message",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  }

  local input = Input(input_popup_options, {
    prompt = "> ",
    on_submit = function (text)
      os.execute("git commit -m \"" .. text .. "\"")
      print("Committed message!")
    end
  })

  local layout = Layout(
  {
    position = "50%",
    size = {
      width = "70%",
      height = "70%",
    },
  },
  Layout.Box({
    Layout.Box(popup, { size = "100%" }),
    Layout.Box(input, { size = 3 })
  }, { dir = "col" })
  )

  layout:mount()

  local prefixed_added_files = {}
  local prefix = "> "
  for i, element in ipairs(added_files) do
    prefixed_added_files[i] = prefix .. element
  end

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, prefixed_added_files)
end

return M
