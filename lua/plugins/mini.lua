require("mini.notify").setup()
require("mini.basics").setup()
require("mini.files").setup()
require("mini.icons").setup()
require("mini.pick").setup()
require("mini.completion").setup()
require("mini.comment").setup()
require("mini.extra").setup()
require("mini.git").setup()
require("mini.diff").setup()

-- Keep this at bottom
require("plugins.mini-statusline")

local utils = require("utils")

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

utils.create_keymap("n", "<leader>pb", ":Pick buffers<cr>", "Buffer selection")
