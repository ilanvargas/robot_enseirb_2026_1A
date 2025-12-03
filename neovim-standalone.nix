{ pkgs ? import <nixpkgs> {} }:

let
  # Import de nixvim
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-25.05";
  });
  
  # Votre configuration nixvim
  nixvimConfig = {
    globals.mapleader = " ";

    extraConfigLua = ''
      -- Folding uniquement pour C/C++
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "h", "hpp", "java" },
        callback = function()
          vim.opt_local.foldmethod = "expr"
          vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
          vim.opt_local.foldenable = true
          vim.opt_local.foldlevel = 99
        end
      })

      -- ouvre un term a droite
      vim.keymap.set('n', '<leader>t', function()
        vim.cmd('vsplit')
        vim.cmd('wincmd l')
        vim.cmd('terminal')
        vim.cmd('startinsert')
      end, { desc = 'Open terminal in right split' })

      -- ferme le terminal avec Esc ou space t
      vim.keymap.set('t', '<Esc>', '<C-\\><C-n>:q<CR>', {})
      vim.keymap.set('t', '<leader>t', '<C-\\><C-n>:q<CR>', {})

      -- Configuration des diagnostics avec hover automatique
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          source = "always",
        },
        float = {
          source = "always",
          border = "rounded",
          header = "",
          prefix = "",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Hover automatique sur diagnostic
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
          }
          vim.diagnostic.open_float(nil, opts)
        end
      })

      -- Raccourcis
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle Neotree' })
      vim.keymap.set('n', '<leader>z', ':Telescope find_files<CR>', { desc = 'Find files' })
      vim.keymap.set('n', '<F5>', ':setlocal foldmethod=syntax<CR>', { desc = 'Enable syntax folding' })
      vim.keymap.set('n', '<F6>', ':setlocal foldenable!<CR>', { desc = 'Toggle folding' })

      -- Raccourcis pour diagnostics
      vim.keymap.set('n', '<F7>', vim.diagnostic.open_float, { desc = 'Show diagnostic popup' })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })

      -- Indentation en mode Visual
      vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent and keep selection' })
      vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Outdent and keep selection' })
      vim.keymap.set('v', '>', '>gv', { desc = 'Indent and reselect' })
      vim.keymap.set('v', '<', '<gv', { desc = 'Outdent and reselect' })

      -- Indentation en mode Normal
      vim.keymap.set('n', '<Tab>', '>>', { desc = 'Indent current line' })
      vim.keymap.set('n', '<S-Tab>', '<<', { desc = 'Outdent current line' })
      
      -- Navigation entre fenêtres
      vim.keymap.set("n", "<leader>h", "<C-\\><C-n><C-w>h", {})
      vim.keymap.set("n", "<leader>j", "<C-\\><C-n><C-w>j", {})
      vim.keymap.set("n", "<leader>k", "<C-\\><C-n><C-w>k", {})
      vim.keymap.set("n", "<leader>l", "<C-\\><C-n><C-w>l", {})

      vim.keymap.set({'n', 'i', 't'}, '<A-h>', '<C-Left>')
      vim.keymap.set({'n', 'i', 't'}, '<A-j>', '<S-Up>')
      vim.keymap.set({'n', 'i', 't'}, '<A-k>', '<S-Down>')
      vim.keymap.set({'n', 'i', 't'}, '<A-l>', '<C-Right>')

      -- Configuration du terminal
      local terminal = vim.api.nvim_create_augroup("TerminalLocalOptions", { clear = true })

      vim.api.nvim_create_autocmd({ "TermOpen" }, {
        group = terminal,
        pattern = { "*" },
        callback = function(event)
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.cursorline = false
          vim.opt_local.signcolumn = "no"
          vim.opt_local.statuscolumn = ""
          
          vim.keymap.set("t", "<leader>h", "<C-\\><C-n><C-w>h", {})
          vim.keymap.set("t", "<leader>j", "<C-\\><C-n><C-w>j", {})
          vim.keymap.set("t", "<leader>k", "<C-\\><C-n><C-w>k", {})
          vim.keymap.set("t", "<leader>l", "<C-\\><C-n><C-w>l", {})

          if vim.bo.filetype == "" then
            vim.api.nvim_set_option_value("filetype", "terminal", { buf = event.buf })
            vim.cmd.startinsert()
          end
        end,
      })

      vim.api.nvim_create_autocmd({ "WinEnter" }, {
        group = terminal,
        pattern = { "*" },
        callback = function()
          if vim.bo.filetype == "terminal" then
            vim.cmd.startinsert()
          end
        end,
      })
    '';

    opts = {
      number = true;
      relativenumber = true;
      smartindent = false;
      cindent = false;
      autoindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
      foldmethod = "indent";
      foldlevel = 99;
      foldenable = false;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      softtabstop = 4;
      colorcolumn = "80";
      textwidth = 80;
    };

    keymaps = [
      {
        key = "<leader>f";
        action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
        mode = "n";
      }
    ];

    colorschemes.gruvbox.enable = true;

    extraPackages = with pkgs; [
      nixfmt-rfc-style
      rustfmt
      black
      prettierd
      clang-tools
      shfmt
      stylua
    ];

    autoCmd = [
      {
        event = "FileType";
        pattern = "conf";
        command = "setlocal shiftwidth=4 tabstop=4 expandtab";
      }
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal shiftwidth=2 tabstop=2 expandtab";
      }
      {
        event = "FileType";
        pattern = "css";
        command = "setlocal iskeyword+=@-@";
      }
    ];

    plugins = {
      gitsigns.enable = true;
      web-devicons.enable = true;

      nvim-ufo = {
        enable = true;
        settings = {
          provider_selector = ''
            function(bufnr, filetype, buftype)
              if filetype == "c" or filetype == "cpp" or filetype == "java" then
                return {"treesitter", "indent"}
              else
                return {"indent"}
              end
            end
          '';
          fold_virt_text_handler = ''
            function(virtText, lnum, endLnum, width, truncate)
              local newVirtText = {}
              local suffix = ('  %d lines '):format(endLnum - lnum)
              local sufWidth = vim.fn.strdisplaywidth(suffix)
              local targetWidth = width - sufWidth
              local curWidth = 0

              for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                  table.insert(newVirtText, chunk)
                else
                  chunkText = truncate(chunkText, targetWidth - curWidth)
                  local hlGroup = chunk[2]
                  table.insert(newVirtText, {chunkText, hlGroup})
                  chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  break
                end
                curWidth = curWidth + chunkWidth
              end

              table.insert(newVirtText, {suffix, 'Comment'})
              return newVirtText
            end
          '';
        };
      };

      neo-tree.enable = true;
      telescope.enable = true;

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
          pyright.enable = true;
          jdtls.enable = true;
          clangd.enable = true;
          bashls.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          cssls.enable = true;
          html.enable = true;
          ltex.enable = true;
          ocamllsp.enable = true;
          postgres_lsp.enable = true;
          matlab_ls.enable = true;
          gitlab_ci_ls.enable = true;
        };
      };

      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
            { name = "luasnip"; }
          ];
          mapping = {
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.close()";
          };
        };
      };

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      friendly-snippets.enable = true;
      comment.enable = true;

      treesitter = {
        enable = true;
        settings = {
          ensure_installed = [
            "nix"
            "rust"
            "python"
            "java"
            "c"
            "cpp"
            "bash"
            "json"
            "yaml"
            "lua"
            "ini"
            "toml"
          ];
          highlight.enable = true;
          indent.enable = true;
          fold = {
            enable = true;
            fold_one_liner = false;
          };
        };
      };

      lualine.enable = true;

      conform-nvim = {
        enable = true;
        settings.formatters_by_ft = {
          nix = [ "nixfmt" ];
          rust = [ "rustfmt" ];
          python = [ "black" ];
          javascript = [ "prettierd" ];
          typescript = [ "prettierd" ];
          json = [ "prettierd" ];
          html = [ "prettierd" ];
          css = [ "prettierd" ];
          c = [ "clang_format" ];
          cpp = [ "clang_format" ];
          sh = [ "shfmt" ];
          lua = [ "stylua" ];
          java = [ "clang_format" ];
          conf = [ "clang_format" ];
        };

        settings.formatters = {
          nixfmt = {
            prepend_args = [ "--indent=2" "--width=80" ];
          };
          rustfmt = {
            prepend_args = [ "--config" "tab_spaces=4,max_width=80" ];
          };
          black = {
            prepend_args = [ "--line-length" "80" "--skip-string-normalization" ];
          };
          prettierd = {
            prepend_args = [ "--tab-width" "4" "--print-width" "80" "--use-tabs" "false" ];
          };
          clang_format = {
            prepend_args = [ "--style={IndentWidth: 4, UseTab: Never, ColumnLimit: 80}" ];
          };
          shfmt = {
            prepend_args = [ "-i" "4" "-ci" ];
          };
          stylua = {
            prepend_args = [ "--indent-type" "Spaces" "--indent-width" "4" "--column-width" "80" ];
          };
        };
      };
    };
  };

in
nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
  inherit pkgs;
  module = nixvimConfig;
}
