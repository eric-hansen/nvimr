local keymap = require('utils').create_keymap

keymap('n', '<leader><leader>', function ()
	require('which-key').show()
end, 'Open which-key (buffer-local)')

