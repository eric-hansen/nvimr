local utils = require("utils")

require("mini.notify").setup()
require("mini.basics").setup()
require("mini.files").setup()
require("mini.icons").setup()
require("mini.pick").setup({
	window = { config = utils.center_window }
})
require("mini.completion").setup({
	lsp_completion = {
		source_func = 'omnifunc',
	}
})
require("mini.comment").setup()
require("mini.extra").setup()
require("mini.git").setup()
require("mini.diff").setup()
require("mini.pairs").setup()
require('mini.extra').setup()
require('mini.ai').setup()

-- Keep this at bottom
require("plugins.mini-statusline")

vim.notify = require("mini.notify").make_notify({
	ERROR = { duration = 5000 },
	WARN = { duration = 4000 },
	INFO = { duration = 3000 },
})

utils.create_keymap(
	"n",
	"<leader>fb",
	':lua require("mini.files").open()<cr>',
	"Open file browser"
)

local keycode = vim.keycode or function(x)
	return vim.api.nvim_replace_termcodes(x, true, true, true)
end
local keys = {
	['cr']        = keycode('<CR>'),
	['ctrl-y']    = keycode('<C-y>'),
	['ctrl-y_cr'] = keycode('<C-y><CR>'),
}

_G.cr_action = function()
	if vim.fn.pumvisible() ~= 0 then
		-- If popup is visible, confirm selected item or add new line otherwise
		local item_selected = vim.fn.complete_info()['selected'] ~= -1
		return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
	else
		-- If popup is not visible, use plain `<CR>`. You might want to customize
		-- according to other plugins. For example, to use 'mini.pairs', replace
		-- next line with `return require('mini.pairs').cr()`
		return require('mini.pairs').cr()
	end
end

utils.create_keymap("n", "<leader>pb", ":Pick buffers<cr>", "Buffer selection")
utils.create_keymap("n", "<leader>fp", ":Pick files<CR>", "File picker")
utils.create_keymap("i", "<CR>", 'v:lua._G.cr_action()', "Custom enter-key action", { expr = true })
utils.create_keymap("n", "<leader>fw", ":Pick grep_live<cr>", "Live grep project")

vim.ui.select = require('mini.pick').ui_select

-- Customize with fourth argument inside a function wrapper
vim.ui.select = function(items, opts, on_choice)
	local start_opts = { window = { config = { width = vim.o.columns } } }
	return require('mini.pick').ui_select(items, opts, on_choice, start_opts)
end
