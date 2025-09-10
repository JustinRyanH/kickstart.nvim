function InsertFullPath()
  local filepath = vim.fn.expand '%'
  vim.fn.setreg('+', filepath) -- write to clippoard
end

function InsertRelativePath()
  local filepath = vim.fn.expand '%:.'
  vim.fn.setreg('+', filepath) -- write to clippoard
end

vim.keymap.set('n', '<leader>dp', InsertFullPath, { desc = 'copy [d]ocument [p]ath', noremap = true, silent = true })
vim.keymap.set('n', '<leader>dr', InsertRelativePath, { desc = 'copy [d]ocument [r]elative path', noremap = true, silent = false })

local projectfile = vim.fn.getcwd() .. '\\project.godot'
if vim.fn.filereadable(projectfile) == 1 then
  vim.fn.serverstart '127.0.0.1:6004'
end

vim.o.expandtab = true

-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = false,
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
      {
        '<leader>sR',
        function()
          require('spectre').open()
        end,
        desc = '[s]earch [R]eplace (Spectre)',
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    config = true,
    keys = {
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[s]earch [t]odo' },
      { '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = '[s]earch [T]odos/Fix/Fixme' },
    },
  },
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { -- Example mapping to toggle outline
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {
      -- Your setup opts here
    },
  },
  { 'almo7aya/openingh.nvim' },
  {
    'NStefan002/screenkey.nvim',
    keys = {
      { '<leader>tS', '<cmd>Screenkey toggle<CR>', desc = '[t]oggle [S]creen key' },
    },
  },
  {
    'habamax/vim-godot',
    event = 'VimEnter',
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'jfpedroza/neotest-elixir',
    },

    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-elixir',
        },
      }
    end,
    keys = {
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = '[t]est [S]ummary',
      },
      {
        '<leader>tf',
        function()
          require('neotest').summary.open()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = '[t]est current [f]ile',
      },
      {
        '<leader>tn',
        function()
          require('neotest').summary.open()
          require('neotest').run.run()
        end,
        desc = '[t]est [n]earest test',
      },
      {
        '<leader>tr',
        function()
          require('neotest').summary.open()
          require('neotest').run.run_last()
        end,
        desc = '[t]est [r]ecent',
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = true,
        max_lines = 3,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
      }
    end,
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed.
      'nvim-telescope/telescope.nvim', -- optional
    },
    keys = {
      { '<leader>ln', '<cmd>Neogit<cr>', desc = 'Neogit' },
    },
  },
  -- {
  --   'synic/refactorex.nvim',
  --   ft = 'elixir',
  --   opts = {
  --     auto_update = true,
  --     pin_version = nil,
  --   },
  -- },
}
