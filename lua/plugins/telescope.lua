return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")

		-- Define your custom picker function outside of the Telescope setup configuration
		local function find_files_custom()
			builtin.find_files({
				theme = "cursor",
				layout_config = {
					width = 0.9, -- Customize the width
					height = 0.2, -- Customize the height
				},
			})
		end
		require("telescope").setup({
			defaults = {
				bottom_pane = {
					height = 25,
					preview_cutoff = 120,
					prompt_position = "top",
				},
				center = {
					height = 0.4,
					preview_cutoff = 40,
					prompt_position = "top",
					width = 0.5,
				},
				cursor = {
					height = 0.9,
					preview_cutoff = 40,
					width = 0.8,
				},
				horizontal = {
					height = 0.9,
					preview_cutoff = 120,
					prompt_position = "bottom",
					width = 0.8,
				},
				vertical = {
					height = 0.9,
					preview_cutoff = 40,
					prompt_position = "cursor",
					width = 0.8,
				},
			},
			pickers = {
				find_files = {
					theme = "cursor",
					layout_config = {
						width = 0.9, -- Customize the width for find_files
						height = 0.5, -- Customize the height for find_files
					},
				},
				-- live_grep = {
				-- 	theme = "dropdown",
				-- 	layout_config = {
				-- 		width = 0.6, -- Customize the width for live_grep
				-- 		height = 0.6, -- Customize the height for live_grep
				-- 	},
				-- },
				--
				-- ... other picker configurations
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				}
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>gb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>gf", find_files_custom, {})

		-- Load extensions after configuring Telescope
		require("telescope").load_extension("ui-select")


		-- Key bindings for telescope-dap
		vim.keymap.set('n', '<leader>Wc', function()
			require'telescope'.extensions.dap.commands{}
		end, {desc = 'DAP Commands'})
		
		vim.keymap.set('n', '<leader>Wo', function()
			require'telescope'.extensions.dap.configurations{}
		end, {desc = 'DAP Configurations'})
		
		vim.keymap.set('n', '<leader>Wb', function()
			require'telescope'.extensions.dap.list_breakpoints{}
		end, {desc = 'List DAP Breakpoints'})
		
		vim.keymap.set('n', '<leader>Wv', function()
			require'telescope'.extensions.dap.variables{}
		end, {desc = 'DAP Variables'})
		
		vim.keymap.set('n', '<leader>Wf', function()
			require'telescope'.extensions.dap.frames{}
		end, {desc = 'DAP Frames'})
		require("telescope").load_extension("dap")
	end,
}
