-- Leader 键设置（必须在最开始）
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Tab 和缩进设置
vim.opt.expandtab = true -- 将 Tab 转换为空格
vim.opt.shiftwidth = 4        -- 自动缩进时使用的空格数
vim.opt.tabstop = 4        -- Tab 在屏幕上显示的宽度
vim.opt.softtabstop = 4       -- 编辑模式下按 Tab 或退格键时处理的空格数

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- 剪贴板配置
vim.opt.clipboard = "unnamedplus" -- 使用系统剪贴板
