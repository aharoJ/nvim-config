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
				-- LUA -----------------------------------------
				null_ls.builtins.formatting.stylua,
				-- JAVA -----------------------------------------
				-- null_ls.builtins.formatting.google_java_format, -- ***WE USE FTPLUGIN/JAVA.LUA***
				-- null_ls.builtins.diagnostics.checkstyle, -- ***WE USE FTPLUGIN/JAVA.LUA***
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
				-- null_ls.builtins.formatting.black,
				-- null_ls.builtins.formatting.isort,
				-- XML -------------------------------------
				null_ls.builtins.formatting.tidy,
				null_ls.builtins.diagnostics.tidy,
			},
		})

		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
	end,
}

-- diagnostic == linting
-- formatting == format

-- diagnostic == linting
-- formatting == format
