return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "gbprod/none-ls-shellcheck.nvim", -- shellcheck
    "nvimtools/none-ls-extras.nvim", -- eslint_d
  },
  config = function()
    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -------------------        JAVA       ------------------------
        -- formatting -- ***WE USE FTPLUGIN/JAVA.LUA***
        --  diagnostics -- ***WE USE FTPLUGIN/JAVA.LUA***
        ----------------                              ----------------

        -------------------        LUA       ------------------------
        null_ls.builtins.formatting.stylua,
        --  diagnostics -- ***WE USE lua_ls**
        ----------------                              ----------------

        -------------------        BASH       ------------------------
        null_ls.builtins.formatting.shfmt,
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
        ----------------                              ----------------

        -------------------        TS | JS       ------------------------
        null_ls.builtins.formatting.prettierd,
        require("none-ls.diagnostics.eslint_d"), -- TS | JS
        -------------------        HTML       ------------------------
        null_ls.builtins.diagnostics.markdownlint, -- HTML
        -------------------        CSS       ------------------------
        null_ls.builtins.diagnostics.stylelint, -- CSS
        ----------------                              ----------------

        -------------------        GO       ------------------------
        null_ls.builtins.diagnostics.staticcheck,
        null_ls.builtins.formatting.asmfmt,
        ----------------                              ----------------

        -------------------        PYTHON       ------------------------
        -- null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.isort,
        ----------------                              ----------------

        -------------------        XML       ------------------------
        null_ls.builtins.formatting.tidy,
        null_ls.builtins.diagnostics.tidy,
        ----------------                              ----------------

        -------------------        MARKDOWN       ------------------------
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.markdownlint,
        ----------------                              ----------------

        -------------------        TOML       ------------------------
        -- formatting -- ***WE USE TAPLO***
        --  diagnostics -- ***WE USE TAPLO***
        ----------------                              ----------------
      },
    })

    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
  end,
}

-- diagnostic == linting
-- formatting == format
