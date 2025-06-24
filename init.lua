-- Установка Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Базовые настройки цвета
vim.opt.termguicolors = true
vim.cmd("colorscheme elflord") -- есть ещё slate, но пока тещу elflord

-- Базовые настройки
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true

-- Плагины
require("lazy").setup({
  -- Treesitter (подсветка)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua" },
        highlight = { 
          enable = true,
          disable = { "punctuation.bracket" },
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- Файловый менеджер
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<F2>", ":NvimTreeToggle<CR>")
    end,
  },
})

-- Принудительный TSUpdate после загрузки
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.cmd("TSUpdate")
  end,
})
