{ config, pkgs, lib, ... }:

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
    neovim
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

    btop  # replacement of htop/nmon
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
    package = pkgs.emacs;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
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

  # gnome
  dconf.settings = with lib.hm.gvariant; {

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "de+nodeadkeys" ]) ];
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
