--- nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup {}

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup{
  mapping = {
   -- ['<C-p>'] = cmp.mapping.select_prev_item(),
   -- ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
   -- ['<C-Space>'] = cmp.mapping.complete(),
   -- ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- use Tab and shift-Tab to navigate autocomplete menu
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  snippet = {
    expand = function(args)
        luasnip.lsp_expand(args.body)
    end
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        lspconfig = "[LSP]",
        otter = "[Otter]",
        luasnip = "[Snippet]",
        pandoc_references = "[ref]",
        buffer = "[Buffer]",
        path = "[Path]",
        cmd_line="[cmd_line]"
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'otter' }, -- for quarto code chunks
    { name = 'nvim_lsp' },
    { name = 'pandoc_references' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
    window = {
          documentation = {
            border = require 'misc.style'.border,
          },
        },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
    require("luasnip.loaders.from_vscode").lazy_load()
}

-- Cmdline completion for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Cmdline completion for '/' and '?'
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})


-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,noinsert'

