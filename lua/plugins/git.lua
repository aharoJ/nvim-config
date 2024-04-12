return {
  -- { "tpope/vim-fugitive" },

  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true, -- nice bar on the left
        numhl = false, -- turns numbers into higlight groups
        linehl = false, -- highlights sections
        word_diff = false,
        watch_gitdir = {
          follow_files = true,
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false, -- the little message saying who committed the line
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        yadm = {
          enable = false,
        },
      })
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -------------------        CUSTOM TOGGLE       ------------------------
      local enabled = true -- default state, adjust as needed
      function ToggleGitsigns()
        local gitsigns = require("gitsigns")
        enabled = not enabled

        if enabled then
          gitsigns.toggle_signs(true)
          gitsigns.toggle_numhl(true)
          gitsigns.toggle_linehl(true)
          gitsigns.toggle_word_diff(true)
          gitsigns.toggle_current_line_blame(true)
        else
          -- Disable all or specific gitsigns features
          gitsigns.toggle_signs(false)
          gitsigns.toggle_numhl(false)
          gitsigns.toggle_linehl(false)
          gitsigns.toggle_word_diff(false)
          gitsigns.toggle_current_line_blame(false)
        end
      end

      vim.api.nvim_set_keymap("n", "<leader>tg", ":lua ToggleGitsigns()<CR>", { noremap = true, silent = true })
      ----------------                              ----------------

      -- map("n", "<leader>tgs", gs.stage_hunk)
      -- map("n", "<leader>tgr", gs.reset_hunk)
      -- map("v", "<leader>tgs", function()
      -- 	gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      -- end)
      -- map("v", "<leader>tgr", function()
      -- 	gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      -- end)
      -- map("n", "<leader>tgS", gs.stage_buffer)
      -- map("n", "<leader>tgu", gs.undo_stage_hunk)
      -- map("n", "<leader>tgR", gs.reset_buffer)
      -- map("n", "<leader>tgb", function()
      -- 	gs.blame_line({ full = true })
      -- end)
      -- map("n", "<leader>tgd", gs.diffthis)
      -- map("n", "<leader>tgD", function()
      -- 	gs.diffthis("~")
      -- end)
      --
      -- map("n", "<leader>tgg", gs.toggle_current_line_blame)
      -- map("n", "<leader>tgt", gs.toggle_deleted)
      --
      -- -- -- Text object
      -- map({ "o", "x" }, "<leader>tgi", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  },
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  {
    "github/copilot.vim",
    config = function()
      -------------------        REMOVE TAB       ------------------------
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
      ----------------                              ----------------

      -------------------        CUSTOM TOGGLE       ------------------------
      _G.copilot_enabled = true
      vim.cmd("Copilot enable") -- Make sure Copilot is enabled at start

      function ToggleCopilot()
        if _G.copilot_enabled then
          vim.cmd("Copilot disable")
          _G.copilot_enabled = false
          print("Copilot disabled")
        else
          vim.cmd("Copilot enable")
          _G.copilot_enabled = true
          print("Copilot enabled")
        end
      end

      vim.api.nvim_set_keymap("n", "<Leader>tc", ":lua ToggleCopilot()<CR>", { noremap = true, silent = true })
      ----------------                              ----------------

      -------------------       MAPS       ------------------------
      -- <C-[> breaks Nvim
      vim.api.nvim_set_keymap("i", "<C-H>", "<Plug>(copilot-dismiss)", { silent = true, noremap = false })
      vim.api.nvim_set_keymap("i", "<C-]>", "<Plug>(copilot-next)", { silent = true, noremap = false }) -- Cycle to the next suggestion
      ----------------                              ----------------
    end,
  },
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
}
