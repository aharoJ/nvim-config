return {
	"shellRaining/hlchunk.nvim",
	event = { "UIEnter" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				notify = false,
				use_treesitter = false, -- important as I dont want the RED line 
				-- details about support_filetypes and exclude_filetypes in https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
				-- support_filetypes = ft.support_filetypes,
				-- exclude_filetypes = ft.exclude_filetypes,
				chars = {
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = ">",
				},
				style = {
					{ fg = "#806d9c" },
					{ fg = "#c21f30" }, -- th--[[ is ]] fg is used to highlight wrong chunk
				},
				textobject = "",
				max_file_size = 1024 * 1024,
				error_sign = false,
			},

			indent = {
				enable = false,
				use_treesitter = false,
				chars = {
					"│",
				},
				style = {
					{ fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") },
				},
			},

			line_num = {
				enable = false,
				use_treesitter = false,
				style = "#806d9c",
			},

			blank = {
				enable = false,
				chars = {
					"․",
				},
				style = {
					vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
				},
			},
		})
	end,
}
