return {

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	{
		"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
		config = function()
			require("toggle_lsp_diagnostics").init()
			vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>(toggle-lsp-diag)", { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap('n', '<leader>ctu', '<Plug>(toggle-lsp-diag-underline)', { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap('n', '<leader>cts', '<Plug>(toggle-lsp-diag-signs)', { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap('n', '<leader>ctv', '<Plug>(toggle-lsp-diag-vtext)', { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap('n', '<leader>ctp', '<Plug>(toggle-lsp-diag-update_in_insert)', { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap('n', '<leader>tldd', '<Plug>(toggle-lsp-diag-default)', { noremap = true, silent = true })
		end,
	},
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	{
		"mfussenegger/nvim-jdtls", -- ***Java LSP***
	},
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "tsserver", "bashls" },
				automatic_installation = true,
			})
		end,
	},
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		dependencies = { "folke/neodev.nvim", opts = {} },
		lazy = false,
		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		config = function()
			-------------------    DAP UI    ------------------------
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})
			----------------                              ----------------
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-------------------        TS | JS       ------------------------
			local lspconfig = require("lspconfig")
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			-------------------        HTML       ------------------------
			-- npm i -g vscode-langservers-extracted
			local capabilities_html = vim.lsp.protocol.make_client_capabilities()
			capabilities_html.textDocument.completion.completionItem.snippetSupport = true
			lspconfig.html.setup({
				capabilities = capabilities_html,
			})
			-------------------        CSS       ------------------------
			require("lspconfig").tailwindcss.setup({ -- TAILWINDCSS
				capabilities = capabilities,
			})

			local capabilities_css = vim.lsp.protocol.make_client_capabilities()
			capabilities_css.textDocument.completion.completionItem.snippetSupport = true
			require("lspconfig").cssls.setup({ -- NORMAL CSS
				capabilities = capabilities_css,
			})
			----------------                              ----------------

			-------------------        XML       ------------------------
			lspconfig.lemminx.setup({
				capabilities = capabilities,
			})
			----------------                              ----------------

			-------------------        MARKDOWN       ------------------------
			require("lspconfig").marksman.setup({
				capabilities = capabilities,
			})
			----------------                              ----------------

			-------------------        TOML       ------------------------
			require("lspconfig").taplo.setup({
				capabilities = capabilities,
			})
			----------------                              ----------------

			-------------------        PYTHON       ------------------------
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			----------------                              ----------------

			-------------------        LUA       ------------------------
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			----------------                              ----------------

			-------------------        YAML       ------------------------
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
			----------------                              ----------------

			-------------------        BASH       ------------------------
			lspconfig.bashls.setup({
				capabilities = capabilities,
				cmd = { "bash-language-server", "start" },
				filetypes = { "sh", "bash" }, -- You can add more file types here if needed
			})
			----------------                              ----------------

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { noremap = true, silent = true })
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>cS", vim.lsp.buf.signature_help, { noremap = true, silent = true })
			vim.keymap.set("n", "<space>cwa", vim.lsp.buf.add_workspace_folder, { noremap = true, silent = true })
			vim.keymap.set("n", "<space>cwr", vim.lsp.buf.remove_workspace_folder, { noremap = true, silent = true })
			vim.keymap.set("n", "<space>cR", vim.lsp.buf.rename, { noremap = true, silent = true })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })
			vim.keymap.set("n", "<space>co", vim.diagnostic.open_float, { noremap = true, silent = true })
			vim.keymap.set("n", "<space>cq", vim.diagnostic.setloclist, { noremap = true, silent = true })
			vim.keymap.set("n", "<space>ct", vim.lsp.buf.type_definition, { noremap = true, silent = true })

			vim.keymap.set("n", "<space>cwl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, { noremap = true, silent = true })

			-- vim.keymap.set("n", "<space>cf", function()
			--   vim.lsp.buf.format({ async = true })
			-- end, { noremap = true, silent = true })
		end,
	},
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
}
