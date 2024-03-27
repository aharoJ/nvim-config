return {
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
      --
      --

      -- <C-[> breaks Nvim
      -- Dismiss the current suggestion
      vim.api.nvim_set_keymap("i", "<C-H>", "<Plug>(copilot-dismiss)", { silent = true, noremap = false })

      -- Cycle to the next suggestion
      vim.api.nvim_set_keymap("i", "<C-K>", "<Plug>(copilot-next)", { silent = true, noremap = false })

      -- Cycle to the previous suggestion
      vim.api.nvim_set_keymap("i", "<M-[>", "<Plug>(copilot-previous)", { silent = true, noremap = false })

      -- Explicitly request a suggestion
      vim.api.nvim_set_keymap("i", "<M-\\>", "<Plug>(copilot-suggest)", { silent = true, noremap = false })

      -- Accept the next word of the current suggestion
      vim.api.nvim_set_keymap("i", "<M-Right>", "<Plug>(copilot-accept-word)", { silent = true, noremap = false })

      -- Define a global variable to track Copilot's enable/disable state
      _G.copilot_enabled = true

      -- Function to toggle Copilot
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

      -- Key mapping to toggle Copilot
      vim.api.nvim_set_keymap("n", "<Leader>cC", ":lua ToggleCopilot()<CR>", { noremap = true, silent = true })

    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      -------------------    TAB MAGIC    ------------------------
      local function check_backspace()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
      end
      ----------------                              ----------------
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -------------------    TAB FORWARD    ------------------------
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),

          -------------------    TAB BACKWARDS    ------------------------
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        ----------------                              ----------------
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}

-- worry about yourself
