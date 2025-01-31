local snippets = require('mini.snippets')

local match_strict = function(snips)
	-- Do not match with whitespace to cursor's left
	return snippets.default_match(snips, { pattern_fuzzy = '%S+' })
end

local gen_loader = snippets.gen_loader
snippets.setup({
	snippets = {
		-- Load custom file with global snippets first
		gen_loader.from_file('~/.config/nvim/snippets/global.json'),

		-- Load snippets based on current language by reading files from
		-- "snippets/" subdirectories from 'runtimepath' directories.
		gen_loader.from_lang(),
	},
	mappings = {
		expand = '', jump_next = '', jump_prev = ''
	},
	expand = {
		match = match_strict
	},
})

local expand_or_jump = function()
	local can_expand = #snippets.expand({ insert = false }) > 0
	if can_expand then
		vim.schedule(snippets.expand); return ''
	end
	local is_active = snippets.session.get() ~= nil
	if is_active then
		snippets.session.jump('next'); return ''
	end
	return '\t'
end

local jump_prev = function() snippets.session.jump('prev') end
vim.keymap.set('i', '<Tab>', expand_or_jump, { expr = true })
vim.keymap.set('i', '<S-Tab>', jump_prev)

local fin_stop = function(args)
	if args.data.tabstop_to == '0' then snippets.session.stop() end
end
local au_opts = { pattern = 'MiniSnippetsSessionJump', callback = fin_stop }
vim.api.nvim_create_autocmd('User', au_opts)

local make_stop = function()
	au_opts = { pattern = '*:n', once = true }
	au_opts.callback = function()
		while snippets.session.get() do
			snippets.session.stop()
		end
	end
	vim.api.nvim_create_autocmd('ModeChanged', au_opts)
end
local opts = { pattern = 'MiniSnippetsSessionStart', callback = make_stop }
vim.api.nvim_create_autocmd('User', opts)
