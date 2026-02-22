-----------------------------------------------------------------------------
-- PLUGINS
-----------------------------------------------------------------------------

-- vimwiki
--if vim.fn.hostname() == "kheshatta" then
--    vim.g.vimwiki_list = { { path = "/home/gig/wiki" } }
--elseif vim.fn.hostname() == "sanctuary" then
--    vim.g.vimwiki_list = { { path = "/storage/wiki" } }
--end

vim.g.blamer_date_format = "%Y-%m-%d"

-- remove docx and xlsx from zip.vim
vim.g.zipPlugin_ext = "*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx"

-- colors
--vim.cmd.colorscheme("gruber")
--vim.cmd.colorscheme("srcery")
--vim.cmd.colorscheme("paper")
vim.cmd.colorscheme("miss-dracula")
--vim.cmd.colorscheme("paper")
--if vim.fn.hostname() == "sanctuary" then
--    vim.cmd("let g:accent_colour = 'red'")
--else
--    vim.cmd("let g:accent_colour = 'blue'")
--end
----vim.cmd("let g:accent_darken = 1")
--vim.cmd("let g:accent_no_bg = 1")
--vim.cmd.colorscheme("accent")

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
                    disable = {}, -- list of language that will be disabled
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

    --{
    --    "lukas-reineke/indent-blankline.nvim",
    --    config = function()
    --        local highlight = { "IndentLine" }
    --        local hooks = require("ibl.hooks")
    --        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    --            local fg = (vim.o.background == "dark" and "#202020" or "#dddddd")
    --            --local fg = (vim.o.background == "dark" and "#21364f" or "#dddddd")
    --            vim.api.nvim_set_hl(0, "IndentLine", { fg = fg })
    --        end)

    --        require("ibl").setup({ indent = { highlight = highlight } })
    --    end
    --},

    { "karb94/neoscroll.nvim", main = "neoscroll", opts = {} },

    --{
    --    "sphamba/smear-cursor.nvim",
    --    main = "smear_cursor",
    --    opts = {}
    --},

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

    --{ "APZelos/blamer.nvim", keys = { { "<C-b>", "<cmd>BlamerToggle<CR>" } } },
    "APZelos/blamer.nvim",

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
    --    "p00f/alabaster.nvim",
    --    config = function()
    --        vim.cmd.colorscheme("alabaster")
    --    end
    --},

    --{
    --    "savq/melange-nvim",
    --    config = function()
    --        vim.cmd.colorscheme("melange")
    --    end
    --},

    --{
    --    "vague-theme/vague.nvim",
    --    config = function()
    --        vim.cmd.colorscheme("vague")
    --    end
    --},

    --{
    --    "oonamo/ef-themes.nvim",
    --    config = function()
    --        --vim.cmd.colorscheme("ef-arbutus")
    --        --vim.cmd.colorscheme("ef-summer")
    --        --vim.cmd.colorscheme("ef-cherie")
    --        vim.cmd.colorscheme("ef-rosa")
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
                    --theme = "melange",
                    --theme = "alabaster",
                    section_separators = "",
                    component_separators = ""
                },
                sections = {
                    lualine_x = { lsp_clients, "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" } -- "progress"
                }
            })
        end
    },

    { "j-hui/fidget.nvim", main = "fidget", opts = {} },

    "tpope/vim-repeat",

    --"vimwiki/vimwiki",

    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },

    {
        "serenevoid/kiwi.nvim",
        opts = {
            {
                name = "wiki",
                path = vim.fn.hostname() == "kheshatta" and "/home/gig/wiki" or "/storage/wiki",
            }
        },
        keys = {
            { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
            { "T", ":lua require(\"kiwi\").todo.toggle()<cr>", desc = "Toggle Markdown Task" }
        },
        lazy = true
    },

    --"saghen/blink.indent",

    {
        "saghen/blink.cmp",
        version = "*",
        opts = {
            keymap = {
                preset = "super-tab"
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono"
            },
            --enabled = function(ctx)
            --    return ctx.mode ~= "cmdline"
            --end,
            cmdline = {
                enabled = false
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = {
                max_typos = function(keyword)
                    return math.floor(#keyword / 0)
                end
            }
        },
        opts_extend = { "sources.default" }
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp"
        },
        keys = {
            { "<leader>l", "<cmd>LspInfo<CR>" }
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
            local servers = require("my").lsp_servers

            for _, lsp in ipairs(servers) do
                local options = {
                    capabilities = capabilities,
                    flags = {
                        debounce_text_changes = 150
                    }
                }

                -- Usually use ruby-lsp as part of a Rails project, which spins
                -- it up on a unix socket using socat. Connect to that here to
                -- prevent spawning a new ruby-lsp in every nvim instance
                if lsp == "ruby_lsp" then
                    local project_socket = "/tmp/ruby-lsp-" .. vim.fn.system({
                        "bash", "-c", [[echo "]] .. vim.fn.getcwd() .. [[" | md5sum | cut -c1-8 | tr -d '\n']]
                    }) .. ".sock"

                    options.cmd = { "socat", "-", "UNIX-CONNECT:" .. project_socket }
                    options.root_markers = { "Gemfile", ".git" }
                elseif lsp == "rubocop" then
                    options.cmd = { "rubocop", "--lsp" }
                    options.root_markers = { "Gemfile", ".git" }
                end

                vim.lsp.config(lsp, options)
                vim.lsp.enable(lsp)
            end

            vim.diagnostic.config({
                virtual_text = true,
                current_line = true
            })
        end,
        lazy = false
    },

    {
      "NeogitOrg/neogit",
      dependencies = {
          "nvim-lua/plenary.nvim",
          "sindrets/diffview.nvim",
          "nvim-telescope/telescope.nvim"
      },
      keys = {
          { "<leader>g", function() require("neogit").open() end },
          { "<leader>k", function() vim.cmd("NeogitLogCurrent") end }
      },
      opts = {
          commit_view = {
              kind = "split" -- default vsplit; split below instead of to the side
          }
      },
      config = true
    },

    --{
    --    "yetone/avante.nvim",
    --    event = "VeryLazy",
    --    lazy = false,
    --    version = false,
    --    opts = {
    --        provider = "openai",
    --        auto_suggestions_provider = "openai",
    --        providers = {
    --            openai = {
    --                endpoint = "https://api.deepseek.com/v1",
    --                model = "deepseek-coder",
    --                timeout = 30000,
    --                max_tokens = 4096,
    --                api_key_name = "cmd:gpg -dq /home/gig/.deepseek.gpg",
    --                -- api_key_name = "OPENAI_API_KEY", -- default OPENAI_API_KEY if not set
    --            }
    --        },
    --        windows = {
    --            position = "bottom"
    --        }
    --    },
    --    build = "make",
    --    dependencies = {
    --        "stevearc/dressing.nvim",
    --        "nvim-lua/plenary.nvim",
    --        "MunifTanjim/nui.nvim",
    --        "nvim-tree/nvim-web-devicons",
    --        -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    --        {
    --            "HakonHarnes/img-clip.nvim",
    --            event = "VeryLazy",
    --            opts = {
    --                default = {
    --                    embed_image_as_base64 = false,
    --                    prompt_for_file_name = false,
    --                    drag_and_drop = {
    --                        insert_mode = true,
    --                    },
    --                    use_absolute_path = true,
    --                },
    --            },
    --        },
    --        {
    --            -- Make sure to set this up properly if you have lazy=true
    --            "MeanderingProgrammer/render-markdown.nvim",
    --            opts = {
    --                file_types = { "markdown", "Avante" },
    --            },
    --            ft = { "markdown", "Avante" },
    --        },
    --    },
    --},

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
    "imsnif/kdl.vim",
})

-- open vimwiki links in a new vim buffer instead of xdg-open
--vim.cmd [[
--    fun! VimwikiLinkHandler(link)
--        let link_infos = vimwiki#base#resolve_link(a:link)
--        try
--            if link_infos.filename =~ "^http"
--                exe '!$BROWSER "' . fnameescape(link_infos.filename) . '"'
--            else
--                exe "e " . fnameescape(link_infos.filename)
--            endif
--            return 1
--        catch
--            echo "Failed opening " . a:link
--            return 0
--        endtry
--    endfun
--]]
