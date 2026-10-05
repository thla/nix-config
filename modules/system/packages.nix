{ pkgs, ... }:

{

  # Install firefox.
  programs.firefox.enable = true;




programs.dms-shell = {
  enable = true;

  systemd.enable = false;             # Systemd service for auto-start
  
};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
  # For newer NixOS versions (25.05+)
  nerd-fonts.fira-code
  nerd-fonts.jetbrains-mono
  nerd-fonts.hack
];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    fish
    google-chrome
    fuzzel

    gnome-tweaks
    #gnome-extensions-tracker
    # Beispiel für eine beliebte Erweiterung (Dash to Panel)

    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.arc-menu
    gnomeExtensions.daily-bing-wallpaper

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
    zip
    unzip
    _7zz
    ripgrep
    tree-sitter
    nil  # Nix Language Server

    # Compiler & Cargo
    rustc
    cargo
    rustfmt
    clippy
    lldb
    gcc
    gnumake
    nodejs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
