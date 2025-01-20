local keymap = vim.keymap

M = {}

M.create_keymap = function (modes, key_combo, exec, desc)
	opts = {}
	
	if desc ~= nil then opts.desc = desc end

	keymap.set(modes, key_combo, exec, opts)
end

return M
