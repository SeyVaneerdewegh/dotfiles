-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

local clip = '/mnt/c/Windows/System32/clip.exe' -- Change this path if needed

if vim.fn.executable(clip) then
  local opts = {
    callback = function()
      if vim.v.event.operator ~= 'y' then
        return
      end
      vim.fn.system(clip, vim.fn.getreg(0))
    end,
  }

  opts.group = vim.api.nvim_create_augroup('WSLYank', {})
  vim.api.nvim_create_autocmd('TextYankPost', { group = opts.group, callback = opts.callback })
end

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
