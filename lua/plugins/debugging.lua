return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- "nvim-neotest/nvim-nio",
    -- "folke/neodev.nvim",
    -- "rcarriga/nvim-dap-ui",
  },
  config = function()

  -- CHECK WHICH_KEY INSTEAD FOR `DEBUG+`
  vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
  vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
  vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
  vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
  vim.keymap.set("n", "<Leader>di", ":DapStepInto<CR>")
  vim.keymap.set("n", "<Leader>dO", ":DapStepOutCR>")
  end,
}