-----------------------------------------------------------------------------
-- PACKAGE MANAGER
-----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- ~/.local/share/nvim
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------------------------
-- VARS
-----------------------------------------------------------------------------
local my = require("my")
require("my.options")
require("my.keybinds")
require("my.autocmd")
require("my.plugins")
