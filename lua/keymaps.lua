-- Global keymaps that don't apply to anything else
local utils = require('utils')

utils.create_keymap('n', '<C-s>', ':w!<cr>', 'Save File (normal mode)')
