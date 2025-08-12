vim.g.mapleader = " "

vim.keymap.set('n', '<Leader>pv', ':Ex<cr>')
vim.keymap.set('n', '<Leader>o', ':update<cr> :so %<cr>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<A-m>', ':w<cr>:make<cr>:copen<cr>')
vim.keymap.set('n', '<A-n>', ':cnext<cr>')
vim.keymap.set('n', '<A-d>', ':cclose<cr>')
vim.keymap.set('n', '<Esc>', function() vim.cmd('noh') end)
vim.keymap.set('n', '<A-t>', ':vim TODO **<cr>:copen<cr>')

vim.o.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.scrolloff = 15
vim.o.colorcolumn = "110"
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.textwidth = 75

vim.o.makeprg = 'build.bat'

-- C Indent Options
vim.opt.cino = { "t0", "(0" }

vim.pack.add({
    { src = 'https://github.com/ellisonleao/gruvbox.nvim.git', name = 'gruvbox' },
    { src = 'https://github.com/echasnovski/mini.pick.git' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim.git' }
})

  local win_config = function()
    local height = math.floor(0.2 * vim.o.lines)
    local width = math.floor(0.4 * vim.o.columns)
    return {
      anchor = 'NW', height = height, width = width,
      row = math.floor(0.5 * (vim.o.lines - height)),
      col = math.floor(0.5 * (vim.o.columns - width)),
    }
  end
require("mini.pick").setup({
   window = { config = win_config }, 
})
vim.keymap.set('n', '<C-p>', ':Pick files<cr>')
vim.keymap.set('n', '<C-h>', ':Pick help<cr>')

require("gruvbox").setup({
    terminal_colors = false,
    italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
    },
    strikethrough = true,
    inverse = true,
    contrast = "hard",
    transparent_mode = true,
})

require('lualine').setup()

vim.cmd.colorscheme('gruvbox')


-- TODO(liam): Wow!
-- NOTE(liam): Look at that!
-- IMPORTANT(liam): Awsome Highlighting!
-- STUDY(liam): Im so good at neovim config!
vim.cmd.highlight({ "clear", "Todo" })
vim.cmd.highlight({ "Todo", "gui=underline", "guifg=red" })
vim.cmd.highlight({ "Note", "gui=underline", "guifg=lightgreen" })
vim.cmd.highlight({ "Study", "gui=underline", "guifg=lightblue" })
vim.cmd.highlight({ "Important", "gui=underline", "guifg=magenta" })

local highlightAutoCmds = vim.api.nvim_create_augroup('highlightAutoCmds', { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*",
    group = highlightAutoCmds,
    callback = function()
        vim.fn.matchadd("Todo", "TODO")
        vim.fn.matchadd("Note", "NOTE")
        vim.fn.matchadd("Study", "STUDY")
        vim.fn.matchadd("Important", "IMPORTANT")
    end
})

local winAutoCmdGroup = vim.api.nvim_create_augroup('winAutoCmdGroup', { clear = true })

vim.api.nvim_create_user_command('Reload', 'luafile $MYVIMRC', {})
