-----------------------------------------------------------------------------
-- AUTOCMDS
-----------------------------------------------------------------------------
local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local ag = augroup("default", {})
local ft = augroup("filetypes", {})
local lsp = augroup("lsp", {})

-- shortly highlight yanks
au("TextYankPost", {
    group = ag, pattern = "*", callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250, on_visual = true })
    end
})

au("WinEnter", { group = ag, pattern = "*", callback = function() vim.opt_local.cursorline = true end })
au("WinLeave", { group = ag, pattern = "*", callback = function() vim.opt_local.cursorline = false end })

-- highlight extra whitespace
local hlstmt = [[highlight ExtraWhitespace ctermbg=red guibg=red]]
vim.cmd(hlstmt)
au("ColorScheme", { group = ag, pattern = "*", callback = function() vim.cmd(hlstmt) end })
vim.cmd [[match ExtraWhitespace /\s\+$\| \+\ze\t/]]

-- only show color col in insert mode
au("InsertEnter", { group = ag, pattern = "*", callback = function() vim.opt.colorcolumn = "78" end })
au("InsertLeave", { group = ag, pattern = "*", callback = function() vim.opt.colorcolumn = "" end })

-- resize splits upon window resize
au("VimResized", { group = ag, pattern = "*", callback = function() vim.cmd [[exe "normal! \<C-w>="]] end })

au("FileType", {
    group = ft, pattern = "c,cpp", callback = function()
        vim.opt_local.cindent = true
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 8
        vim.opt_local.softtabstop = 8
        vim.opt_local.shiftwidth = 8
    end
})

au("FileType", {
    group = ft, pattern = "ruby,haml", callback = function()
        vim.opt_local.textwidth = 120
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

au("FileType", {
    group = ft, pattern = "go", callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 8
        vim.opt_local.softtabstop = 8
        vim.opt_local.shiftwidth = 8
    end
})

au("FileType", {
    group = ft, pattern = "lua", callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4
    end
})

au("FileType", {
    group = ft, pattern = "markdown", callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4
    end
})

au("FileType", {
    group = ft, pattern = "vim", callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4
    end
})

au("FileType", {
    group = ft, pattern = "vue", callback = function()
        vim.opt_local.textwidth = 200
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

au("FileType", {
    group = ft, pattern = "javascript", callback = function()
        vim.opt_local.cindent = false
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

au("FileType", {
    group = ft, pattern = "sh,zsh,bash", callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4
    end
})

au("FileType", {
    group = ft, pattern = "mail", callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.textwidth = 80
        vim.opt_local.formatoptions = "tcqjlw"
    end
})

au("FileType", {
    group = ft, pattern = "vimwiki", callback = function()
        vim.opt_local.wrap = false
        vim.opt_local.textwidth = 200
    end
})

-- compile and run keymaps
au("FileType", { group = ft, pattern = "ruby", callback = function() vim.keymap.set("", "<F6>", ":!ruby %<CR>") end })
au("FileType", { group = ft, pattern = "php", callback = function() vim.keymap.set("", "<F6>", ":!php -f %<CR>") end })
au("FileType", { group = ft, pattern = "python", callback = function() vim.keymap.set("", "<F6>", ":!python %<CR>") end })
au("FileType", { group = ft, pattern = "perl", callback = function() vim.keymap.set("", "<F6>", ":!perl %<CR>") end })
au("FileType", { group = ft, pattern = "lua", callback = function() vim.keymap.set("", "<F6>", ":!lua %<CR>") end })
au("FileType", { group = ft, pattern = "html,xhtml", callback = function() vim.keymap.set("", "<F6>", ":!firefox %<CR>") end })

-- signature thing
au("FileType", {
    group = ft, pattern = "mail", callback = function()
        vim.keymap.set("", "<F6>", "maGkkkdddddddd'ai<CR>--<ESC>:r ~/.config/mutt/signature_work<CR>kk")
    end
})

-- ms word doc reading
au("BufReadPre", { group = ft, pattern = "*.doc{x,}", callback = function() vim.opt_local.readonly = true end })
vim.cmd [[
    au BufReadPost *.doc %!antiword "%"
    au BufReadPost *.docx %!docx2txt "%" -
]]

-- filetype detections
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "*.ru", callback = function() vim.opt_local.filetype = "ruby" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "grub.conf", callback = function() vim.opt_local.filetype = "grub" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "*.es6", callback = function() vim.opt_local.filetype = "javascript" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "*.sql", callback = function() vim.opt_local.filetype = "sql" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "*.svg", callback = function() vim.opt_local.filetype = "svg" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "*.md", callback = function() vim.opt_local.filetype = "markdown" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "*.markdown", callback = function() vim.opt_local.filetype = "markdown" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "mutt{ng,}-*-\\w\\+", callback = function() vim.opt_local.filetype = "mail" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "*.tpl", callback = function() vim.opt_local.filetype = "liquid" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = ".spacemacs", callback = function() vim.opt_local.filetype = "lisp" end })
au({"BufNewFile", "BufRead"}, { group = ft, pattern = "COMMIT_EDITMSG", callback = function() vim.opt_local.filetype = "git" end })

---- load additional plugins based on filetype
--au("BufReadPre", { group = ft, pattern = "*.js", callback = function() vim.cmd("packadd vim-javascript") end })
--au("BufReadPre", { group = ft, pattern = "*.es6", callback = function() vim.cmd("packadd vim-javascript") end })
--au("BufReadPre", { group = ft, pattern = "*.jsx", callback = function() vim.cmd("packadd vim-jsx") end })
--au("BufReadPre", { group = ft, pattern = "*.vue", callback = function() vim.cmd("packadd vim-vue") end })
--au("BufReadPre", { group = ft, pattern = "*.ts{x,}", callback = function() vim.cmd("packadd typescript-vim") end })
--au("BufReadPre", { group = ft, pattern = "*.haml", callback = function() vim.cmd("packadd vim-haml") end })
--au("BufReadPre", { group = ft, pattern = "*.rs", callback = function() vim.cmd("packadd rust.vim") end })
--au("BufReadPre", { group = ft, pattern = "*.ex{s,}", callback = function() vim.cmd("packadd elixir-tools.nvim") end })
--au("BufReadPre", { group = ft, pattern = "*.{l,}eex", callback = function() vim.cmd("packadd elixir-tools.nvim") end })
--au("BufReadPre", { group = ft, pattern = "*.cr", callback = function() vim.cmd("packadd vim-crystal") end })
--au("BufReadPre", { group = ft, pattern = "*.toml", callback = function() vim.cmd("packadd vim-toml") end })
--au("BufReadPre", { group = ft, pattern = "*.md", callback = function() vim.cmd("packadd vim-markdown") end })

-- transparent editing of gpg encrypted files.
-- by Wouter Hanegraaff
vim.cmd [[
    augroup encrypted
        au!
        autocmd BufReadPre,FileReadPre *.gpg set viminfo=
        autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup
        autocmd BufReadPre,FileReadPre *.gpg set bin
        autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
        autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null
        autocmd BufReadPost,FileReadPost *.gpg set nobin
        autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
        autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
        autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
        autocmd BufWritePost,FileWritePost *.gpg u
    augroup END
]]

-- lsp stuff
au("LspAttach", {
    group = lsp,
    callback = function(args)
        --local bufnr = args.buf
        --local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
        local remapkey = require("my").remapkey

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

        remapkey("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
        remapkey("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
        remapkey("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
        remapkey("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
        remapkey("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
        remapkey("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
        remapkey("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
        remapkey("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
        remapkey("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
        remapkey("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
        remapkey("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
        remapkey("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
        remapkey("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
        remapkey("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
        remapkey("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
        remapkey("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
        remapkey("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    end
})
