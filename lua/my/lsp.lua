vim.cmd [[
    packadd nvim-navic
    packadd nvim-lspconfig
    packadd nvim-cmp
    packadd cmp-nvim-lsp
    packadd cmp-buffer
    packadd cmp-path
]]

local cmp = require("cmp")
cmp.setup({
    --snippet = {
    --    -- REQUIRED - you must specify a snippet engine
    --    expand = function(args)
    --        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    --        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    --        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    --        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    --    end,
    --},
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" })
    },
    sources = {
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer", keyword_length = 2 },
        { name = "path" },
        -- { name = "vsnip" }, -- For vsnip users.
        -- { name = "luasnip" }, -- For luasnip users.
        -- { name = "ultisnips" }, -- For ultisnips users.
        -- { name = "snippy" }, -- For snippy users.
    }
})

local navic = require("nvim-navic")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(client, bufnr)
    local function remapbufkey(...) vim.api.nvim_remapbufkey(bufnr, ...) end
    local function bufsetopt(...) vim.api.nvim_bufsetopt(bufnr, ...) end

    -- enable completion triggered by <c-x><c-o>
    bufsetopt("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true }

    remapbufkey("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    remapbufkey("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    remapbufkey("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    remapbufkey("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    remapbufkey("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    remapbufkey("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    remapbufkey("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    remapbufkey("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    remapbufkey("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    remapbufkey("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    remapbufkey("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    remapbufkey("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    remapbufkey("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    remapbufkey("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    remapbufkey("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    remapbufkey("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    remapbufkey("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

local servers = { "ruby_lsp", "gopls", "rust_analyzer", "bashls", "pyright", "ccls", "tsserver", "cssls" }
local nvim_lsp = require("lspconfig")
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150
        }
    })
end
