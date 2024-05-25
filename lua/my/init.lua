-----------------------------------------------------------------------------
-- VARS
-----------------------------------------------------------------------------

--local handle = io.popen("hostname")
--local hostname = handle:read("*a")
--hostname = hostname:gsub("[\n\r]", "")
--handle:close()

local M = {}

--M.hostname = hostname

M.lsp_servers = {
    "ruby_lsp",
    "gopls",
    "rust_analyzer",
    "bashls",
    "pyright",
    "ccls",
    "tsserver",
    "cssls",
    "lua_ls"
}

M.remapkey = function(mode, key, action)
    vim.keymap.set(mode, key, action, { noremap = true, silent = true })
end

return M
