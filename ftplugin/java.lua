local capabilities = require("cmp_nvim_lsp").default_capabilities()
local project_root = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])

local config_java = {
	-- cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
	cmd = { "/Users/aharo/.local/share/nvim/mason/bin/jdtls" },
	root_dir = project_root,
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		-- You can put your buffer-specific key mappings here, for example:
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
	end,
	init_options = {
		bundles = {
			vim.fn.glob("/Users/aharo/.config/nvim/ftplugin/java-debug/com.microsoft.java.debug.plugin-0.51.1.jar", 1),
		},
	},
}

-- Setup DAP (Debug Adapter Protocol) for Java, if necessary.
require("jdtls").setup_dap({ hotcodereplace = "auto" })

-- Start or attach to the LSP server for the current buffer
require("jdtls").start_or_attach(config_java)

-- Set indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-------------------    RUNS PROJECT ------------------------
vim.cmd([[
function! CompileAndRunJavaPackage()
    let l:current_file = expand('%')
    let l:package_directory = expand('%:p:h')
    let l:parent_directory = fnamemodify(l:package_directory, ':h')
    " Compile all Java files in the current package directory
    let compile_command = '!javac ' . l:package_directory . '/*.java'
    execute compile_command
    " Determine the package name by extracting the relative path and replacing slashes with dots
    let l:package_name = substitute(l:package_directory, l:parent_directory.'/', '', '')
    let l:package_name = substitute(l:package_name, '/', '.', 'g')
    " Extract the class name from the current file name
    let l:class_name = fnamemodify(l:current_file, ':t:r')
    " Concatenate to form the fully qualified class name
    let l:full_class = l:package_name . '.' . l:class_name
    " Run the compiled class without opening a new buffer or window
    let run_command = '!java -cp ' . l:parent_directory . ' ' . l:full_class
    execute run_command
endfunction
]])

vim.api.nvim_set_keymap("n", "<Space>rp", ":call CompileAndRunJavaPackage()<CR>", { noremap = true, silent = true })
----------------                              ----------------

-------------------    RUNS FILE    ------------------------
vim.api.nvim_set_keymap(
	"n",
	"<Space>rf",
	':w!<CR>:!javac % && echo "" && echo "OUTPUT:" && java %<CR>',
	{ noremap = true, silent = true }
)
----------------                              ----------------
