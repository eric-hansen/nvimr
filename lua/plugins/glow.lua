if vim.fn.executable("glow") ~= 0 then
    require("glow").setup({
        style = "dark",
        default_type = "preview",
    })
else
    vim.notify("glow needs to be installed first!", vim.log.levels.ERROR)
end
