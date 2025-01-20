vim.g._colorscheme = "kanagawa"

local rocks_config = {
    rocks_path = vim.env.HOME .. "/.local/share/nvim-rocks/rocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(
        rocks_config.rocks_path,
        "share",
        "lua",
        "5.1",
        "?",
        "init.lua"
    ),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),

    -- add these on Windows
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(
    vim.fs.joinpath(
        rocks_config.rocks_path,
        "lib",
        "luarocks",
        "rocks-5.1",
        "rocks.nvim",
        "*"
    )
)

vim.cmd("colorscheme " .. vim.g._colorscheme)

vim.opt.clipboard = "unnamedplus"

-- If WSL is in use, use wl-copy/wl-paste
if vim.fn.has("wsl") == 1 then
    if vim.fn.executable("wl-copy") == 0 then
        print("wl-clipboard not found, clipboard integration won't work")
    else
        vim.g.clipboard = {
            name = "wl-clipboard (wsl)",
            copy = {
                ["+"] = "wl-copy --foreground --type text/plain",
                ["*"] = "wl-copy --foreground --primary --type text/plain",
            },
            paste = {
                ["+"] = function()
                    return vim.fn.systemlist(
                        'wl-paste --no-newline|sed -e "s/\r$//"',
                        { "" },
                        1
                    ) -- '1' keeps empty lines
                end,
                ["*"] = function()
                    return vim.fn.systemlist(
                        'wl-paste --primary --no-newline|sed -e "s/\r$//"',
                        { "" },
                        1
                    )
                end,
            },
            cache_enabled = true,
        }
    end
end

require("keymaps")
require("plugins.init")
