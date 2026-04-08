-----------------------------------------------------------------------------
-- PACKS
-----------------------------------------------------------------------------

local remapkey = require("my").remapkey

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
            vim.cmd("TSUpdate")
        end
    end
})

vim.g.blamer_date_format = "%Y-%m-%d"

-- remove docx and xlsx from zip.vim
vim.g.zipPlugin_ext = "*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx"

vim.pack.add({ "https://github.com/ThunderBoltCODMYT/gruber-darker.vim" })
vim.cmd("colorscheme gruber-darker")

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/editorconfig/editorconfig-vim",
    "https://github.com/tpope/vim-endwise",
    "https://github.com/APZelos/blamer.nvim",
    "https://github.com/tpope/vim-repeat",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/dense-analysis/ale"
})

vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
require("nvim-web-devicons").setup({})

vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })
require("nvim-treesitter").install({
    "ruby", "yaml", "vue", "javascript", "python", "c", "cpp", "css",
    "elixir", "go", "json", "html", "scss", "lua", "bash", "typescript",
    "tsx", "rust"
})

vim.pack.add({ "https://github.com/akinsho/bufferline.nvim" })
require("bufferline").setup({})

vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" })
require("telescope").setup({
    pickers = {
        find_files = {
            theme = "ivy" -- dropdown
        }
    }
})
remapkey("n", "<leader>ff", function() require("telescope.builtin").find_files() end)
remapkey("n", "<leader>fg", function() require("telescope.builtin").live_grep() end)
remapkey("n", "<leader>fb", function() require("telescope.builtin").buffers() end)
remapkey("n", "<leader>fh", function() require("telescope.builtin").help_tags() end)

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup({})

vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
require("nvim-autopairs").setup({})

vim.pack.add({ "https://github.com/brenoprata10/nvim-highlight-colors" })
require("nvim-highlight-colors").setup({
    render = "virtual",
    virtual_symbol = "■",
    enable_named_colors = false,
    enable_tailwind = false
})

vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({
    options = {
        theme = "gruber-darker",
        section_separators = "",
        component_separators = ""
    },
    sections = {
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" }
    }
})

vim.pack.add({ "https://git.3kgcat.fi/muwiki.nvim" })
local muwiki = require("muwiki")
muwiki.setup({
    dirs = {
        {
            name = "default",
            path = vim.fn.hostname() == "kheshatta" and "/home/gig/wiki" or "/storage/wiki"
        }
    }
})
remapkey("n", "<leader>ww", function() require("muwiki").open_index("default") end)
local muwiki_group = vim.api.nvim_create_augroup("muwiki", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = muwiki_group,
    pattern = "markdown",
    callback = function(ev)
        if not muwiki.wiki_root(ev.buf) then return end
        local keymap_opts = { buffer = ev.buf, silent = true, nowait = true }
        vim.keymap.set("n", "<CR>", muwiki.open_link, keymap_opts)
        vim.keymap.set("n", "<Tab>", muwiki.next_link, keymap_opts)
        vim.keymap.set("n", "<S-Tab>", muwiki.prev_link, keymap_opts)
        vim.keymap.set("v", "<CR>", muwiki.create_link, keymap_opts)
        vim.keymap.set('n', '<S-t>', muwiki.toggle_checkbox, keymap_opts)
    end,
})

vim.pack.add({ "https://github.com/NeogitOrg/neogit" })
require("neogit").setup({
    commit_view = {
        kind = "split" -- default vsplit; split below instead of to the side
    }
})
remapkey("n", "<leader>g", function() require("neogit").open() end)
remapkey("n", "<leader>k", function() vim.cmd("NeogitLogCurrent") end)

vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" } })
require("blink.cmp").setup({
    keymap = {
        preset = "super-tab"
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono"
    },
    -- enabled = function(ctx)
    --     return ctx.mode ~= "cmdline"
    -- end,
    cmdline = {
        enabled = false
    },
    sources = {
        -- default = { "lsp", "path", "snippets", "buffer" },
        default = { "path", "snippets", "buffer" },
    },
    fuzzy = {
        max_typos = function(keyword)
            return math.floor(#keyword / 0)
        end
    }
})
--opts_extend = { "sources.default" }

-- Language stuff
vim.pack.add({
    "https://github.com/vim-ruby/vim-ruby",
    "https://github.com/tpope/vim-rails",
    "https://github.com/tpope/vim-haml",
    "https://github.com/tpope/vim-markdown",
    "https://github.com/pangloss/vim-javascript",
    "https://github.com/mxw/vim-jsx",
    "https://github.com/posva/vim-vue",
    "https://github.com/leafgarland/typescript-vim",
    "https://github.com/rust-lang/rust.vim",
    "https://github.com/elixir-tools/elixir-tools.nvim",
    "https://github.com/rhysd/vim-crystal",
    "https://github.com/cespare/vim-toml",
    "https://github.com/imsnif/kdl.vim"
})
