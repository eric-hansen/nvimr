local utils = require('utils')

require('lazygit')

utils.create_keymap('n', '<leader>gg', ':LazyGit<cr>', 'Load Lazygit window')
