-----------------------------------------------------------------------------
-- PLUGINS
-----------------------------------------------------------------------------

-- vimwiki
if vim.fn.hostname() == "kheshatta" then
    vim.g.vimwiki_list = {{ path = "/home/gig/wiki" }}
elseif vim.fn.hostname() == "sanctuary" then
    vim.g.vimwiki_list = {{ path = "/storage/wiki" }}
end

-- remove docx and xlsx from zip.vim
vim.g.zipPlugin_ext = "*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx"

require("lazy").setup({
    "nvim-lua/plenary.nvim",

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "ruby", "yaml", "vue", "javascript", "python", "c", "cpp", "css",
                    "elixir", "go", "json", "html", "scss", "lua", "bash", "typescript",
                    "tsx"
                }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                --ignore_install = { "javascript" }, -- list of parsers to ignore installing
                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = { }, -- list of language that will be disabled
                },
                indent = {
                    enable = true,
                    disable = { "ruby", "yaml", "go" }
                },
                --markid = { enable = true }
            })
        end
    },

    "editorconfig/editorconfig-vim",

    "tpope/vim-endwise",

    { "nvim-tree/nvim-web-devicons", config = function() require("nvim-web-devicons").setup() end },

    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("bufferline").setup({})
        end
    },

    --{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        keys = {
            { "<leader>ff", function() require("telescope.builtin").find_files() end },
            { "<leader>fg", function() require("telescope.builtin").live_grep() end },
            { "<leader>fb", function() require("telescope.builtin").buffers() end },
            { "<leader>fh", function() require("telescope.builtin").help_tags() end },
        },
        config = function()
            require("telescope").setup({
                pickers = {
                    find_files = {
                        theme = "dropdown"
                    }
                }
            })
        end
    },

    "APZelos/blamer.nvim",

    { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },

    { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup({}) end },

    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({
                render = "virtual",
                virtual_symbol = "■",
                enable_named_colors = true,
                enable_tailwind = false
            })
        end
    },

    {
        "Mofiqul/vscode.nvim",
        config = function()
            require("vscode").setup({})
            vim.cmd("colorscheme vscode")
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("lualine").setup({
                options = {
                    --theme = "codedark"
                    theme = "vscode"
                },
                sections = {
                    lualine_y = {} -- "progress"
                }
            })
        end
    },

    "tpope/vim-repeat",

    "vimwiki/vimwiki",

    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" },
        config = function()
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
        end
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp", "SmiteshP/nvim-navic" },
        config = function()
            local navic = require("nvim-navic")

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            local on_attach = function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end

            local servers = { "ruby_lsp", "gopls", "rust_analyzer", "bashls", "pyright", "ccls", "tsserver", "cssls", "lua_ls" }
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
        end
    },

    "vim-ruby/vim-ruby",
    "tpope/vim-rails",
    "tpope/vim-haml",
    "tpope/vim-markdown",
    "pangloss/vim-javascript",
    "mxw/vim-jsx",
    "posva/vim-vue",
    "leafgarland/typescript-vim",
    "rust-lang/rust.vim",
    "elixir-tools/elixir-tools.nvim",
    "rhysd/vim-crystal",
    "cespare/vim-toml"
})

-- open vimwiki links in a new vim buffer instead of xdg-open
vim.cmd [[
    fun! VimwikiLinkHandler(link)
        let link_infos = vimwiki#base#resolve_link(a:link)
        try
            if link_infos.filename =~ "^http"
                exe '!$BROWSER "' . fnameescape(link_infos.filename) . '"'
            else
                exe "e " . fnameescape(link_infos.filename)
            endif
            return 1
        catch
            echo "Failed opening " . a:link
            return 0
        endtry
    endfun
]]