{ config, pkgs, ... }:

{
  #home.username = "your-user";
  #home.homeDirectory = "/home/tomas";

  #programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      nodejs
      python3
      lua-language-server
      rust-analyzer
      go
      php
      jdt-language-server
      tree-sitter
      luarocks
    ];
  };

  xdg.configFile."nvim/init.lua".text = ''
    require("core.options")
    require("core.keymaps")
    require("core.colors")
    require("plugins")
  '';

  xdg.configFile."nvim/lua/core/options.lua".text = ''
    local o = vim.opt

    o.number = true
    o.relativenumber = true
    o.tabstop = 4
    o.shiftwidth = 4
    o.expandtab = true
    o.smartindent = true
    o.wrap = false
    o.termguicolors = true
    o.cursorline = true
    o.signcolumn = "yes"
    o.clipboard = "unnamedplus"
    o.splitright = true
    o.splitbelow = true
  '';

  xdg.configFile."nvim/lua/core/keymaps.lua".text = ''
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("n", "<leader>e", ":Neotree toggle<CR>", opts)
    map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
    map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
    map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
    map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
    map("n", "<leader>tt", ":ToggleTerm<CR>", opts)
  '';

  xdg.configFile."nvim/lua/core/colors.lua".text = ''
#    vim.cmd{ "catppuccin/nvim", name = "catppuccin", priority = 1000 }
  '';

  xdg.configFile."nvim/lua/plugins/init.lua".text = ''
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath
      })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
      { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

      "nvim-lualine/lualine.nvim",
      "nvim-tree/nvim-web-devicons",
      "goolord/alpha-nvim",

      "nvim-neo-tree/neo-tree.nvim",

      { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",

      "lewis6991/gitsigns.nvim",

      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",

      "akinsho/toggleterm.nvim",

      "ahmedkhalf/project.nvim",

      "stevearc/conform.nvim",
    })

    require("plugins.treesiter")
    require("plugins.lsp")
    require("plugins.cmp")
    require("plugins.telescope")
    require("plugins.neotree")
    require("plugins.gitsigns")
    require("plugins.dap")
    require("plugins.statusline")
    require("plugins.dashboard")
    require("plugins.terminal")
    require("plugins.project")
    require("plugins.formatting")
  '';

  xdg.configFile."nvim/lua/plugins/lsp.lua".text = ''
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls", "ts_ls", "pyright", "gopls",
        "rust_analyzer", "jdtls", "phpactor"
      }
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local servers = {
      "lua_ls", "ts_ls", "pyright", "gopls",
      "rust_analyzer", "jdtls", "phpactor"
    }

    for _, server in ipairs(servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end
  '';

  xdg.configFile."nvim/lua/plugins/cmp.lua".text = ''
    local cmp = require("cmp")

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      },
    })
  '';

  xdg.configFile."nvim/lua/plugins/treesitter.lua".text = ''
    return {"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "javascript", "typescript", "python",
        "go", "rust", "php", "java"
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
    end,
}
  '';

  xdg.configFile."nvim/lua/plugins/neotree.lua".text = ''
    require("neo-tree").setup({
      filesystem = {
        follow_current_file = true,
      }
    })
  '';

  xdg.configFile."nvim/lua/plugins/telescope.lua".text = ''
    require("telescope").setup({})
  '';

  xdg.configFile."nvim/lua/plugins/gitsigns.lua".text = ''
    require("gitsigns").setup()
  '';

  xdg.configFile."nvim/lua/plugins/dap.lua".text = ''
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui"] = function() dapui.close() end
  '';

  xdg.configFile."nvim/lua/plugins/statusline.lua".text = ''
    require("lualine").setup({
      options = { theme = "catppuccin" }
    })
  '';

  xdg.configFile."nvim/lua/plugins/dashboard.lua".text = ''
    require("alpha").setup(require("alpha.themes.dashboard").config)
  '';

  xdg.configFile."nvim/lua/plugins/terminal.lua".text = ''
    require("toggleterm").setup()
  '';

  xdg.configFile."nvim/lua/plugins/project.lua".text = ''
    require("project_nvim").setup({})
  '';

  xdg.configFile."nvim/lua/plugins/formatting.lua".text = ''
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        python = { "black" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        php = { "phpcbf" },
      },
    })
  '';
}
