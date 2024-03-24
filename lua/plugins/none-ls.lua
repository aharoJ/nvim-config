return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.completion.spell,
      },
      -- JAVA
      {
        null_ls.builtins.formatting.google_java_format, -- formatter
        null_ls.builtins.diagnostics.checkstyle,    -- linter
      },
      -- RUBY not working on the Mason side tho :(
      {
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.formatting.rubocop,
      },
      -- JS | TS | HTML | CSS and more...
      {
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.eslint_d, -- not recongnized by none-ls doc
      },
      -- GO
      {
        null_ls.builtins.diagnostics.staticcheck, -- linter
        null_ls.builtins.formatting.asmfmt,   -- formatter extends gofmt
      },
      -- PYTHON
      {
        -- null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.isort,
      },
    })

    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
  end,
}

-- diagnostic == linting
-- formatting == format
