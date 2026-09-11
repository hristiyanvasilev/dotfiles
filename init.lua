vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/junegunn/fzf" },
  { src = "https://github.com/junegunn/fzf.vim" },
  { src = "https://github.com/NLKNguyen/papercolor-theme" },
  -- { src = "https://github.com/vim-airline/vim-airline" },
  -- { src = "https://github.com/vim-airline/vim-airline-themes" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/vimwiki/vimwiki" },
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/maxmx03/solarized.nvim" },
  { src = "https://github.com/mcauley-penney/techbase.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
}, { load = true })

vim.o.background = 'light'
vim.o.termguicolors = true
vim.opt.fillchars = { eob = " " }

local solarized = require('solarized')
solarized.setup({})

require("techbase").setup({
  italic_comments = false,
  transparent = false,
  hl_overrides = {},
})


-- Custom commands
vim.api.nvim_create_user_command("InitTab", function()
  vim.cmd("tabedit $MYVIMRC")
end, {})

vim.api.nvim_create_user_command("TermTab", function(opts)
  vim.cmd("tabnew")
  if opts.args ~= "" then
    vim.cmd.terminal(opts.args)
  else
    vim.cmd.terminal()
  end
end, {
  nargs = "*",
  complete = "shellcmd",
})

--TODO: try it out and decide which one is better
--vim.api.nvim_command [[ set number ]]
--vim.api.nvim_command [[ set relativenumber ]]

local set = vim.opt -- set options

-- Insert 4 spaces instead of a tab
set.tabstop = 8
set.softtabstop = 0
set.shiftwidth = 4
set.expandtab=true
set.smarttab=true
-- TODO: test without the status line to see if it is better
set.laststatus = 0

-- Set color scheme and background color
set.termguicolors = true
--set.background = "dark"
set.background = "light"
--vim.api.nvim_command [[ colorscheme catppuccin-mocha ]] vim.api.nvim_command [[ colorscheme gruvbox ]]
--vim.api.nvim_command [[ colorscheme solarized ]]
--vim.api.nvim_command [[ colorscheme PaperColor ]]
--vim.api.nvim_command [[ colorscheme sw1comm ]]
vim.api.nvim_command [[ colorscheme tokyonight-day ]]


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>q", "<cmd>enew | bd#<cr>", { desc = "Close file, keep tab" })

vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied: " .. path)
end, { desc = "Copy current file path" })

vim.keymap.set("n", "<leader>tt", function()
  vim.opt.showtabline = (vim.o.showtabline == 0) and 2 or 0
end, { desc = "Toggle tabline" })

vim.keymap.set("n", "<leader>nn", function()
  vim.wo.number = not vim.wo.number
end, { desc = "Toggle line numbers" })

vim.keymap.set("n", "<leader>nr", function()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle line relative numbers" })

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>',	opts)
vim.api.nvim_set_keymap('n', '[d',       '<cmd>lua vim.diagnostic.goto_prev()<CR>',		opts)
vim.api.nvim_set_keymap('n', ']d',       '<cmd>lua vim.diagnostic.goto_next()<CR>',		opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>',	opts)

vim.api.nvim_set_keymap('n', ',w',       ':Windows<CR>',									opts)
vim.api.nvim_set_keymap('n', ',f',       ':Files<CR>',									opts)
vim.api.nvim_set_keymap('n', ',b',       ':Buffers<CR>',								opts)
vim.api.nvim_set_keymap('n', ',l',       ':Lines<CR>',									opts)
vim.api.nvim_set_keymap('n', ',m',       ':Maps<CR>',									opts)
vim.api.nvim_set_keymap('n', ',s',     	 ':Snippets<CR>',								opts)
vim.api.nvim_set_keymap('n', ',h',       ':Helptags<CR>',								opts)

vim.api.nvim_set_keymap('n', ',r',       ':lua vim.lsp.buf.references()<CR>',								opts)
vim.api.nvim_set_keymap('n', ',d',       ':lua vim.lsp.buf.definition()<CR>',								opts)
vim.api.nvim_set_keymap('n', ',t',       ':lua vim.lsp.buf.workspace_symbol()<CR>',								opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  capabilities = capabilities,
  on_attach = on_attach,
})


vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },

  filetypes = { 'python' },

  capabilities = capabilities,

  on_attach = on_attach,

  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
        typeCheckingMode = 'basic',
      },
    },
  },
})

vim.lsp.enable('clangd')
vim.lsp.enable('pyright')

-- defaults for all servers
vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
})

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
