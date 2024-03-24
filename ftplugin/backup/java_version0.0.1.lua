-- ~/.config/nvim/ftplugin/java.lua
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local project_root = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])

local config_java = {
  cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
  root_dir = project_root,
  capabilities = capabilities,
}

-- Optionally, you can set java-specific LSP keybindings here or in the config function

require('jdtls').start_or_attach(config_java)

-- Set Java-specific keybindings if desired
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = 0 })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = 0 })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })



-- CODE from 3 years ago 

-- local config = {
--   -- cmd = {'/Users/aharo/.local/share/nvim/mason/bin/jdtls'},
--   cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
--   root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
-- }
-- require('jdtls').start_or_attach(config)

-- -- -- decapricated or whoever its spelled
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-- local config = {
--   cmd = {
--     'java',
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1 ',
--     '-Dosgi.bundles.defaultStartLevel=4 ',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product ',
--     '-Dlog.level=ALL ',
--     '-Xmx1G ',
--     '-jar',
--     '/Library/Java/jdt-language-server-1.33.0-202402151717/pluginsorg.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
--     '-configuration', '/Library/Java/jdt-language-server-1.33.0-202402151717/config_mac/',
--     '-data', vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir
--   },

--   root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
--   capabilities = capabilities,
-- }
-- require('jdtls').start_or_attach(config)

-- local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- vim.api.nvim_set_keymap('n', '<leader>lA', '<cmd>lua require(\'jdtls\').code_action()<CR>', { silent = true })
