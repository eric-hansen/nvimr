local utils = require('utils')
local glow = utils.preq('glow')

if vim.fn.executable("glow") ~= 0 and glow ~= nil then
	glow.setup({
		style = "dark",
		default_type = "preview",
	})
else
	vim.notify("glow needs to be installed first!", vim.log.levels.ERROR)
end
