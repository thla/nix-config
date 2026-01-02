{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    fzf
    ripgrep # Required for live_grep
    fd      # Required for faster find_files
    mc
    yazi
    zellij
    ffmpeg
    zoxide
    resvg
    imagemagick
    wl-clipboard
    starship
    zed-editor
    lapce

    # Compiler & Cargo
    rustc
    cargo
    rustfmt
    clippy

     # Debugging
    lldb
    gcc
    vscode-extensions.vadimcn.vscode-lldb

    # Nix Support
    nil nixfmt-rfc-style

    # LSP & Debugging
    rust-analyzer
    bacon            # Background code checker (optional but recommended)
  ];

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
      ruff
      bash-language-server
      yaml-language-server
      vim-language-server
      pyright
      universal-ctags
      #pynwin
    ];
  };

    # 2. Global FZF (Terminal Integration)
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;

      character = {
        success_symbol = "➜";
        error_symbol = "✗";
      };

      git_branch = {
        symbol = " ";
      };
    };
  };

  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };


  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = { x = 8; y = 8; };
        dynamic_padding = true;
        opacity = 0.95;
      };

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 12.0;
      };

      cursor = {
        style = { shape = "Beam"; blinking = "On"; };
      };

      terminal.shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };

      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
      };
    };
  };
}
