return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",              -- source for LSP completions ** IMPORTANT **
      "hrsh7th/cmp-buffer",                -- source for text in buffer
      "hrsh7th/cmp-path",                  -- source for file system paths in commands
      "L3MON4D3/LuaSnip",                  -- snippet engine
      "saadparwaiz1/cmp_luasnip",          -- for lua autocompletion
      "rafamadriz/friendly-snippets",      -- useful snippets library
      "onsails/lspkind.nvim",              -- vs-code like pictograms
      "hrsh7th/cmp-nvim-lsp-document-symbol", -- document symbols
      "hrsh7th/cmp-nvim-lsp-signature-help", -- signature help
      {
        "VonHeikemen/lsp-zero.nvim",       -- TAB | SHIFT-TAB to navigate through snippets
        branch = "v2.x",
      },
    },
    config = function()
      local lspkind = require("lspkind") -- VSCODE
      local cmp_action = require("lsp-zero").cmp_action()
      local cmp = require("cmp")

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
          -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ----------------------------------------------
          ["<C-m>"] = cmp_action.luasnip_jump_backward(),
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-p>"] = cmp_action.luasnip_jump_backward(),
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
          ----------------------------------------------
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        ----------------                              ----------------
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For Snippets
          { name = "nvim_lsp_document_symbol" },
          { name = "nvim_lsp_signature_help" },
          -- { name = "buffer" }, -- text within current buffer -- DISLIKE THIS VERY MUCH 
          { name = "path" }, -- file system paths
        }),
        formatting = {
          format = lspkind.cmp_format({
            -- mode = "symbol",    -- show only symbol annotations
            maxwidth = 50,      -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            symbol_map = {
              Copilot = "",
              Text = "",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "",
              Variable = "",
              Class = "",
              Interface = "",
              Module = "",
              Property = "",
              Unit = "",
              Value = "󰎠",
              Enum = "",
              Keyword = "",
              Snippet = "",
              Color = "",
              File = "",
              Reference = "",
              Folder = "",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "", -- a C language thing
              Event = "",
              Operator = "",
              TypeParameter = "",
            },
          }),
        },
      })
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
      -- -- blue
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#569CD6" })
      -- -- light blue
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#9CDCFE" })
      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#9CDCFE" })
    end,
  },
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
}
