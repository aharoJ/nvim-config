vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.ts = 4
vim.opt_local.expandtab = true

local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

local function capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

local function directory_exists(path)
  local f = io.popen("cd " .. path)
  local ff = f:read("*all")

  if ff:find("ItemNotFoundException") then
    return false
  else
    return true
  end
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- calculate workspace dir
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
if directory_exists(workspace_dir) then
else
  os.execute("mkdir " .. workspace_dir)
end
-- get the mason install path
local install_path = require("mason-registry").get_package("jdtls"):get_install_path()

-- get the current OS
local os
if vim.fn.has("macunix") then
  os = "mac"
elseif vim.fn.has("win32") then
  os = "win"
else
  os = "linux"
end

local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    "\n"
  )
)

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. install_path .. "/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    install_path .. "/config_" .. os,
    "-data",
    workspace_dir,
  },
  capabilities = capabilities(),
  root_dir = root_dir,
  settings = {
    java = {},
  },

  init_options = {
    bundles = {
      vim.fn.glob(
        mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
        "\n"
      ),
    },
  },
}

config["on_attach"] = function(client, bufnr)
  local _, _ = pcall(vim.lsp.codelens.refresh)
  require("jdtls.dap").setup_dap_main_class_configs()
  jdtls.setup_dap({ hotcodereplace = "auto" })
--   require("user.lsp.handlers").on_attach(client, bufnr)
  require("java-conf").on_attach(client, bufnr)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

jdtls.start_or_attach(config)

vim.cmd(
  [[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)]]
)
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--

-------------------     REQUIRE CLIENT    ------------------------
-- -- ERROR: https://github.com/mfussenegger/nvim-jdtls/blob/master/lua/jdtls/dap.lua
-- require("jdtls").test_class()
-- require("jdtls").test_nearest_method()
-- vim.keymap.set("n", "<leader>dZ", function()
--   require("jdtls").test_class()
-- end, { silent = true })
-- vim.keymap.set("n", "<leader>dn", function()
--   require("jdtls").test_nearest_method()
-- end, { silent = true })
----------------                                ----------------

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
