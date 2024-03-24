return {
  "numToStr/Comment.nvim",
  config = function()
    require('Comment').setup {
      padding = true,  ---Add a space b/w comment and the line
      sticky = true,   ---Whether the cursor should stay at its position
      ignore = nil,    ---Lines to be ignored while (un)comment

      toggler = {      ---LHS of toggle mappings in NORMAL mode
        line = 'gcc',  ---Line-comment toggle keymap
        block = 'gbc', ---Block-comment toggle keymap
      },

      opleader = {    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        line = 'gc',  ---Line-comment keymap
        block = 'gb', ---Block-comment keymap
      },

      extra = {        ---LHS of extra mappings
        above = 'gcO', ---Add comment on the line above
        below = 'gco', ---Add comment on the line below
        eol = 'gcA',   ---Add comment at the end of line
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = nil,
      post_hook = nil,
    }


   -- Instead of `gcc` we do <space>/
    -- Normal mode mapping for <Space>/
    vim.api.nvim_set_keymap('n', '<Leader>/', '<Plug>(comment_toggle_linewise_current)', { silent = true })

    -- Visual mode mapping for <Space>/
    vim.api.nvim_set_keymap('x', '<Leader>/', '<Plug>(comment_toggle_linewise_visual)', { silent = true })

  end
}

