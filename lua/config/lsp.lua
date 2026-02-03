-- lua/config/lsp.lua
local M = {}

-- 1. Define Server Configs
M.servers = {
    python = {
        binary = "pyright-langserver",
        args = { "--stdio" },
        root = { "pyproject.toml", "uv.lock", ".git" },
    },
    php = {
        binary = "intelephense",
        args = { "--stdio" },
        root = { "composer.json", ".git" },
        init_options = { storagePath = vim.fn.stdpath("cache") },
    },
    lua = {
        binary = "lua-language-server",
        root = { ".luarc.json", ".git" },
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    },
    html = {
        binary = "vscode-html-language-server",
        args = { "--stdio" },
        root = { ".git" },
    },
    json = {
        binary = "vscode-json-language-server",
        args = { "--stdio" },
        root = { ".git" },
    },
}

-- 2. Helper to find binary in Mason or System
local function get_cmd(name)
    local mason_path = vim.fn.stdpath("data") .. "/mason/bin/" .. name
    if vim.loop.fs_stat(mason_path) then
        return { mason_path }
    elseif vim.fn.executable(name) == 1 then
        return { name }
    end
    return nil
end

-- 3. The Start Function
function M.start(server_key)
    local config = M.servers[server_key]
    if not config then return end

    local cmd = get_cmd(config.binary)
    if not cmd then return end

    if config.args then vim.list_extend(cmd, config.args) end

    -- Use Native 0.11 Start API
    vim.lsp.start({
        name = config.binary,
        cmd = cmd,
        root_dir = vim.fs.root(0, config.root) or vim.fn.getcwd(),
        settings = config.settings,
        init_options = config.init_options,
        -- Link capabilities to Cmp for completion
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
end

return M
