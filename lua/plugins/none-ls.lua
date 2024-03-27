return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    dependencies = {
      "gbprod/none-ls-shellcheck.nvim", -- shellcheck
      "nvimtools/none-ls-extras.nvim", -- eslint_d
    },
  },
  config = function()
    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- LUA -----------------------------------------
        null_ls.builtins.formatting.stylua,
        -- JAVA -----------------------------------------
        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.diagnostics.checkstyle.with({
          extra_args = { "-c", "/google_checks.xml" },
        }),
        -- BASH -----------------------------------------
        null_ls.builtins.formatting.shfmt,
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
        -- JS | TS | HTML | CSS -------------------------
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "html", "json", "yaml", "markdown" },
          extra_filetypes = { "toml" },
        }),
        require("none-ls.diagnostics.eslint_d"),
        -- GO -----------------------------------------
        null_ls.builtins.diagnostics.staticcheck,
        null_ls.builtins.formatting.asmfmt,
        -- PYTHON -------------------------------------
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
      },
    })

    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
  end,
}

-- diagnostic == linting
-- formatting == format
