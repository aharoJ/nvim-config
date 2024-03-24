return {
	"vim-test/vim-test",
	config = function()
		-- Place these in your Neovim lua configuration file, such as init.lua or a file sourced by it

		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		map("n", "<leader>t", ":TestNearest<CR>", opts)
		map("n", "<leader>T", ":TestFile<CR>", opts)
		map("n", "<leader>a", ":TestSuite<CR>", opts)
		map("n", "<leader>l", ":TestLast<CR>", opts)
		map("n", "<leader>g", ":TestVisit<CR>", opts)
	end,
}
