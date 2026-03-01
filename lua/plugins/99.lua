-- 99 AI Agent Configuration
return {
    "ThePrimeagen/99",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    -- Configuration options
    opts = {
        -- Use opencode's free model
        model = "opencode/minimax-m2.5-free",

        display_errors = true,
        completion = {
            source = "cmp",
            custom_rules = {},
        },
        md_files = {
            "AGENT.md",
        },
    },

    -- Setup function using the provided options
    config = function(_, opts)
        require("99").setup(opts)
    end,
}
