local Layout = require("nui.layout")
local Popup = require("nui.popup")
local Menu = require("nui.menu")
local utils = require("forgit.utils")
local replace_char = utils.replace_char

local M = {}

function M.render()
  local modified_files = utils.get_git_modified_files()
  local popup_options = {
    position = "50%",
    border = {
      style = "rounded",
      text = {
        top = "Choose a file to be added",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal",
    }
  }

  local lines = {}
  local files_to_add = {}
  for i, element in ipairs(modified_files) do
    lines[i] = Menu.item(" [ ] " .. element, { index = i })
  end

  local confirm = "-- CONFIRM --"

  table.insert(lines, Menu.item(confirm))
  local function mount_menu()
    local menu = Menu(popup_options, {
      lines = lines,
      keymap = {
        focus_next = {"j", "<Down>", "<Tab>"},
        focus_prev = {"k", "<Up>", "<S-Tab>"},
        close = {"<Esc>", "<C-c>"},
        submit = {"<CR>", "<Space>"},
      },
      on_close = function ()
        files_to_add = {}
      end,
      on_submit = function (item)
        if item.text == confirm then
          for _, element in ipairs(files_to_add) do
            os.execute("git add " .. element)
          end
          files_to_add = {}
        else
          table.insert(files_to_add, string.sub(item.text, 5, string.len(item.text)))
          lines[item.index] = Menu.item(replace_char(3, item.text, "X"), { index = item.index })
          mount_menu()
        end
      end
    })

    local keys = Popup({
      border = {
        style = "rounded",
        text = {
          top = "Keys",
          top_align = "center",
        },
      },
      buf_options = {
        readonly = true,
      }
    })
    vim.api.nvim_buf_set_lines(keys.bufnr, 0, 1, false, {
      "Next: J  Prev: K  Close: <Esc>  Select: <Space> or <CR>"
    })

    local layout = Layout({
      position = "50%",
      size = {
        width = 60,
        height = "70%",
      }
    },
    Layout.Box({
      Layout.Box(menu, { size = "100%" }),
      Layout.Box(keys, { size = 3 })
    }, { dir = "col" }))
    layout:mount()
  end

  mount_menu()
end

return M
