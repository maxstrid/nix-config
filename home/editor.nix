{ config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    extraLuaConfig = ''
      local o = vim.opt
      local api = vim.api

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
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup()
        '';
      }
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
        plugin = gruvbox-material;
        type = "lua";
        config = ''
          vim.o.background = "dark"
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

          lspconfig.rust_analyzer.setup {
            capabilities = capabilities,
          }

          lspconfig.clangd.setup {
            capabilities = capabilities,
            cmd = {'clangd', '--clang-tidy', '--compile-commands-dir=build', '--enable-config'},
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
    ];
    extraPackages = with pkgs; [
      pkgs.rust-analyzer
      pkgs.clang-tools
    ];
  };
}
