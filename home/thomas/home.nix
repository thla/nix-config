{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";

  programs.home-manager.enable = true;

  # Fish shell configuration
  programs.fish = {
    enable = true;
    # Commands run when Fish starts
    loginShellInit = ''
      set -g theme_color_scheme dark
      starship init fish | source
    '';
    shellInit = ''
          # Custom Fish config
      	set -g fish_greeting "Welcome to Fish 🐟"
    '';
    # Example plugins
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
    ];
  };

  # Starship prompt integration
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "➜";
        error_symbol = "✗";
      };
    };
  };

  # User packages
  home.packages = with pkgs; [
    starship
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    tree-sitter
    lazygit
    wget
    nixfmt
    bat
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    meld

    # productivity
    #hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    #build
    bison
    flex
    fontforge
    makeWrapper
    pkg-config
    gnumake
    gcc
    libiconv
    autoconf
    automake
    libtool # freetype calls glibtoolize

    godot_4
    kitty
    kitty-themes
    gh
    vlc
    wezterm
    alacritty
    zellij
    yazi
    lua
    luarocks
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs; # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };

  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
    ];
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
        };
        size = 12.0;
      };
    };
  };

  # Kitty terminalllll
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    shellIntegration.enableFishIntegration = true;
    theme = "Catppuccin-Macchiato";
    #Also available: Catppuccin-Frappe Catppuccin-Latte Catppuccin-Macchiato Catppuccin-Mocha
    # See all available kitty themes at: https://github.com/kovidgoyal/kitty-themes/blob/46d9dfe230f315a6a0c62f4687f6b3da20fd05e4/themes.json
  };

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      lua-language-server
      stylua
      ripgrep
      fd
    ];

    extraLuaConfig = ''
      -- Lazy.nvim setup
      require("lazy").setup({
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },

          -- Rust development plugins
          { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
          { "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
          { "folke/tokyonight.nvim" }, -- theme
          { "neovim/nvim-lspconfig" }, -- core LSP support
          { "simrat39/rust-tools.nvim" }, -- extra rust-analyzer goodies
          { "saecki/crates.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- manage Cargo.toml crates
          { "mfussenegger/nvim-dap" }, -- debugging framework
          { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } }, -- debugger UI
          { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- syntax highlighting

          -- Completion
          {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
              "hrsh7th/cmp-nvim-lsp",
              "hrsh7th/cmp-buffer",
              "hrsh7th/cmp-path",
            },
            config = function()
              local cmp = require("cmp")
              cmp.setup({
                mapping = cmp.mapping.preset.insert(),
                sources = {
                  { name = "nvim_lsp" },
                  { name = "buffer" },
                  { name = "path" },
                },
              })
            end,
          },

          -- Statusline
          { "nvim-lualine/lualine.nvim" },

          -- Git integration
          { "lewis6991/gitsigns.nvim" },
        },
        defaults = { lazy = true },
        readme = { enabled = false },
      })

      -- Example: set colorscheme
      vim.cmd("colorscheme tokyonight")
    '';
  };

  # gnome
  dconf.settings = with lib.hm.gvariant; {

    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "de+nodeadkeys"
        ])
      ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
      ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.8;
      click-action = "previews";
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      dock-fixed = true;
      dock-position = "LEFT";
      extend-height = true;
      height-fraction = 0.9;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
    };
  };

  home.stateVersion = "25.11";
}
