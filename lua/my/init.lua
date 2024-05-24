--local handle = io.popen("hostname")
--local hostname = handle:read("*a")
--hostname = hostname:gsub("[\n\r]", "")
--handle:close()

local M = {}
--M.hostname = hostname

return M
