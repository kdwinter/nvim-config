vim.g.mapleader = ","

function remapkey(mode, key, action)
    vim.keymap.set(mode, key, action, { noremap = true, silent = true })
end

-- common save shortcuts
remapkey("i", "<C-s>", "<Esc>:w<CR>a")
remapkey("n", "<C-s>", ":w<CR>")

-- terminal shortcuts
remapkey("i", "<C-t>", "<Esc>:term<CR>A")
remapkey("n", "<C-t", ":term<CR>A")

-- sane movement with wrap o n
remapkey({"n", "v"}, "j", "gj")
remapkey({"n", "v"}, "k", "gk")
remapkey({"n", "v"}, "<Down>", "gj")
remapkey({"n", "v"}, "<Up>", "gk")
remapkey("i", "<Down>", "<C-o>gj")
remapkey("i", "<Up>", "<C-o>gk")

-- tab key in visual mode
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- visually select the characters that are wanted in the search, then type // to search for the next occurrence of the selected text
remapkey("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>")

-- no ex mode
remapkey("n", "Q", "<Nop>")

-- center current line
remapkey("n", "cc", ":center<CR>")

-- write to files with root privileges
vim.keymap.set("c", "w!!", ":w !sudo tee % >/dev/null")

-- blamer
vim.keymap.set("", "<C-b>", ":BlamerToggle<CR>")

-- quickly show lsp info
remapkey("n", "<leader>l", "<cmd>LspInfo<CR>")

-- typo's
vim.keymap.set("i", "<F1>", "<Esc>")
vim.keymap.set("n", "q:", ":q<CR>")
vim.cmd [[
    ia tongiht tonight
    ia htese these
    ia od do
    ia nothign nothing
    ia htey they
    ia htem them
    ia iwth with
    ia maxium maximum
    ia funtcion function
    ia fucntion function
    ia funciton function
    ia dfe def
    ia edn end
    ia teh the
    ia hte the
    ia htis this
    ia tihs this
    ia taht that
    ia retunr return
    ia reutrn return
    ia eariler earlier
    ia ulness unless
    ia ahve have
    ia chatper chapter
    ia colmun column
    ia amster master
    ia orgiin origin
    ia somehting something
    ia hting thing
    ia orgniaztion organization
    ia orgnization organization
    ia shcool school
]]
