local M = {}

function M.get_git_added_files()
  local handle = io.popen("git ls-files --cached")
  local result = handle:read("*a")
  handle:close()

  local files = {}
  for file in result:gmatch("[^\r\n]+") do
    table.insert(files, file)
  end
  return files
end

function M.get_git_modified_files()
  local git_command = "git ls-files --others --modified --exclude-standard"
  local modified_files = {}

  local handle = io.popen(git_command)
  for line in handle:lines() do
    -- Only add the file if it exists on disk
    if io.open(line, "r") then
      table.insert(modified_files, line)
    end
  end
  handle:close()
  return modified_files
end

function M.replace_char(pos, str, r)
    return ("%s%s%s"):format(str:sub(1,pos-1), r, str:sub(pos+1))
end

return M
