local keymap = vim.keymap

M = {}

M.create_keymap = function(modes, key_combo, exec, desc, opts)
	local _opts = vim.tbl_deep_extend("force", {}, opts or {})

	if desc ~= nil then _opts.desc = desc end

	keymap.set(modes, key_combo, exec, _opts)
end

M.center_window = function()
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		anchor = 'NW',
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

return M
