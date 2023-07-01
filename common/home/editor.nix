{ config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    extraLuaConfig = ''
      local o = vim.opt
      local api = vim.api
      local keymap = api.nvim_set_keymap

      -- Options
      o.number = true
      o.incsearch = true
      o.ignorecase = true
      o.hlsearch = true
      o.ruler = true
      o.ignorecase = true
      o.smartcase = true
      o.showmatch = true
      o.errorbells = false
      o.visualbell = false
      o.backup = false
      o.wb = false
      o.swapfile = false
      o.smarttab = true
      o.signcolumn = 'yes'

      o.tabstop=4
      o.shiftwidth=4
      o.expandtab = true

      o.completeopt = {'menuone', 'noselect', 'noinsert'}
      o.shortmess = o.shortmess + { c = true }

      o.termguicolors = true

      o.clipboard = 'unnamedplus'
      o.cmdheight = 0

      vim.cmd("autocmd FileType nix setlocal tabstop=2 shiftwidth=2 expandtab")
      vim.cmd("autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 expandtab")

      local default_opts = { noremap = true, silent = true }
      vim.g.mapleader = ' '

      keymap("n", "<leader>bp", "<cmd>BufferLinePick<cr>", default_opts)
      keymap("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", default_opts)
      keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", default_opts)
      keymap("n", "<leader>g", "<cmd>Telescope live grep<cr>", default_opts)
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require("nvim-treesitter.configs").setup {
            highlight = { enable = true },
            parser_install_dir = parser_install_dir,
          }
        '';
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup()
        '';
      }
      {
        plugin = gruvbox-material;
        type = "lua";
        config = ''
          vim.o.background = "dark"
          vim.g.gruvbox_material_foreground = 'mix'
          vim.cmd 'colorscheme gruvbox-material'
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require("lualine").setup()
        '';
      }
      # Lsp & Completion
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require("lspconfig")
          local capabilities = require("cmp_nvim_lsp").default_capabilities()

          lspconfig.clangd.setup {
            capabilities = capabilities,
            cmd = {'clangd', '--clang-tidy', '--compile-commands-dir=build', '--enable-config'},
          }

          lspconfig.rnix.setup {
            capabilities = capabilities
          }
        '';
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require("cmp")

          cmp.setup {
            snippet = {
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
              end,
            },
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert {
              ['<Tab>'] = cmp.mapping.select_next_item(),
              ['<S-Tab>'] = cmp.mapping.select_prev_item(),
              ['<C-Tab>'] = cmp.mapping.scroll_docs(4),
              ['<C-p>'] = cmp.mapping.scroll_docs(-4),
              ['<CR>'] = cmp.mapping.confirm { select = true },
            },
            sources = cmp.config.sources {
              { name = 'nvim_lsp' },
              { name = 'vsnip' }, },
              { { name = 'buffer' },
            }
          }
        '';
      }
      cmp-vsnip
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      friendly-snippets
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require("nvim-autopairs").setup()
        '';
      }
      vim-nix
      {
        plugin = rust-tools-nvim;
        type = "lua";
        config = ''
          require('rust-tools').setup()
        '';
      }
      plenary-nvim
      telescope-nvim
      vim-flatbuffers
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          require("gitsigns").setup()
        '';
      }
      {
        plugin = null-ls-nvim;
        type = "lua";
        config = ''
          local null_ls = require 'null-ls'

          null_ls.setup {
              sources = {
                  null_ls.builtins.diagnostics.buildifier,
                  null_ls.builtins.formatting.buildifier,
                  null_ls.builtins.formatting.yapf,
                  null_ls.builtins.completion.spell.with {
                      filetypes = { "markdown", "gitcommit" }
                  }
              },
              on_attach = function(client, bufnr)
                  if client.supports_method("textDocument/formatting") then
                      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                      vim.api.nvim_create_autocmd('BufWritePre', {
                          group = augroup,
                          buffer = bufnr,
                          callback = function()
                              vim.lsp.buf.format()
                          end,
                      })
                  end
              end,
          }
        '';
      }
      indent-blankline-nvim
    ];
    extraPackages = with pkgs; [
      pkgs.rust-analyzer
      pkgs.clang-tools
      pkgs.rnix-lsp
    ];
  };
}
