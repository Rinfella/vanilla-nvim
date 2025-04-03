-- Treesitter configuration

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'vim',
        'vimdoc',
        'lua',
        'cpp',
        'php',
        'go',
        'javascript',
        'typescript',
        'html',
        'css',
        'markdown',
        'markdown_inline',
        'bash',
        'python',
    },

    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    indent = { enable = true },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
    },
}