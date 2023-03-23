require("forgit.remap")

function is_git_installed()
  local result = os.execute("git --version")
  if result == 0 then
    return true
  else
    return false
  end
end

if not is_git_installed() then
  vim.api.nvim_err_writeln("Forgit ERROR: git is not installed!\n"
  .. "The plugin will not work correctly if you do not install it")
end

local M = {}

return M
