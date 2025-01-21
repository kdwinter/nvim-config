-----------------------------------------------------------------------------
-- PLUGINS
-----------------------------------------------------------------------------

-- vimwiki
if vim.fn.hostname() == "kheshatta" then
    vim.g.vimwiki_list = { { path = "/home/gig/wiki" } }
elseif vim.fn.hostname() == "sanctuary" then
    vim.g.vimwiki_list = { { path = "/storage/wiki" } }
end

vim.g.blamer_date_format = "%Y-%m-%d"

-- remove docx and xlsx from zip.vim
vim.g.zipPlugin_ext = "*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx"

-- colors
--vim.cmd.colorscheme("gruber")
vim.cmd.colorscheme("srcery")

-- lazy load plugins from github
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

    { "nvim-tree/nvim-web-devicons", main = "nvim-web-devicons", opts = {} },

    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        main = "bufferline",
        opts = {}
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            local highlight = { "IndentLine" }
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                local fg = (vim.o.background == "dark" and "#202020" or "#dddddd")
                --local fg = (vim.o.background == "dark" and "#21364f" or "#dddddd")
                vim.api.nvim_set_hl(0, "IndentLine", { fg = fg })
            end)

            require("ibl").setup({ indent = { highlight = highlight } })
        end
    },

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
                        theme = "ivy" -- dropdown
                    }
                }
            })
        end
    },

    { "APZelos/blamer.nvim", keys = { { "<C-b>", "<cmd>BlamerToggle<CR>" } } },

    { "lewis6991/gitsigns.nvim", main = "gitsigns", opts = {} },

    { "windwp/nvim-autopairs", main = "nvim-autopairs", opts = {} },

    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({
                render = "virtual",
                virtual_symbol = "■",
                enable_named_colors = false,
                enable_tailwind = false
            })
        end
    },

    --{
    --    "Mofiqul/vscode.nvim",
    --    config = function()
    --        require("vscode").setup({})
    --        vim.cmd.colorscheme("vscode")
    --    end
    --},

    --{
    --    "echasnovski/mini.base16",
    --    config = function()
    --        vim.cmd.colorscheme("minischeme")
    --    end
    --},

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            local lsp_clients = function()
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })
                if next(clients) == nil then
                    return ""
                end

                local c = {}
                for _, client in pairs(clients) do
                    table.insert(c, client.name)
                end
                return "\u{f085}  " .. table.concat(c, " | ")
            end

            require("lualine").setup({
                options = {
                    --theme = "codedark"
                    --theme = "vscode",
                    section_separators = "",
                    component_separators = ""
                },
                sections = {
                    lualine_x = { lsp_clients, "encoding", "fileformat", "filetype" },
                    lualine_y = {} -- "progress"
                }
            })
        end
    },

    { "j-hui/fidget.nvim", main = "fidget", opts = {} },

    "tpope/vim-repeat",

    "vimwiki/vimwiki",

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path"
        },
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
                    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
                    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" })
                },
                sources = {
                    { name = "nvim_lsp", keyword_length = 1 },
                    { name = "buffer", keyword_length = 2 },
                    { name = "path" },
                    --{ name = "vsnip" }, -- For vsnip users.
                    --{ name = "luasnip" }, -- For luasnip users.
                    --{ name = "ultisnips" }, -- For ultisnips users.
                    --{ name = "snippy" }, -- For snippy users.
                }
            })
        end
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "SmiteshP/nvim-navic"
        },
        keys = {
            { "<leader>l", "<cmd>LspInfo<CR>" }
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            local navic = require("nvim-navic")
            local on_attach = function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end

            local servers = require("my").lsp_servers
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
        end,
        lazy = false
    },

    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons"
        },
        main = "barbecue",
        opts = {}
    },

    {
      "NeogitOrg/neogit",
      dependencies = {
          "nvim-lua/plenary.nvim",
          "sindrets/diffview.nvim",
          "nvim-telescope/telescope.nvim"
      },
      keys = {
          { "<leader>g", function() require("neogit").open() end }
      },
      config = true
    },

    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false,
        opts = {
            provider = "openai",
            auto_suggestions_provider = "openai",
            openai = {
                endpoint = "https://api.deepseek.com/v1",
                model = "deepseek-chat",
                timeout = 30000,
                temperature = 0.0,
                max_tokens = 4096,
                api_key_name = "cmd:gpg -dq /home/gig/.deepseek.gpg",
                -- api_key_name = "OPENAI_API_KEY", -- default OPENAI_API_KEY if not set
            },
            windows = {
                position = "bottom"
            }
        },
        build = "make",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            -- "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },

    -- language stuff
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
    "cespare/vim-toml",

    "echasnovski/mini.base16"
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
