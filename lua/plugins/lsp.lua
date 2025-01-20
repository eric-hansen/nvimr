local config = {
    lsp = {
        ["intelephense"] = {},
        ["lua_ls"] = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        },
    },
    format = {},
}

local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set
    -- keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    -- keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    -- keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    -- keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "gl", vim.diagnostic.open_float, opts)
    keymap("n", "]d", vim.diagnostic.goto_next, opts)
    keymap("n", "[d", vim.diagnostic.goto_prev, opts)
    keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
    keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
    keymap("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
    keymap("n", "<leader>li", "<cmd>LspInfo<CR>", opts)
end

local common_capabilities = function(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return capabilities
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
})

for server, opts in pairs(config.lsp) do
    local lsp_opts = {
        on_attach = on_attach,
        capabilities = common_capabilities(server),
    }

    if opts["settings"] ~= nil then
        lsp_opts.settings = opts.settings
    end

    lspconfig[server].setup(lsp_opts)
end

require("conform").setup({
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
    formatters_by_ft = {
        lua = { "stylua" },
    },
})
