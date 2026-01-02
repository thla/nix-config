{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = false;

    # Settings inside config.toml
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true; # Shows a distinct color for different modes (Normal/Insert)
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        lsp.display-messages = true;
      };

      # Keybindings (Mapping 'space' as leader is default in Helix)
      keys.normal = {
        "esc" = [ "collapse_selection" "keep_primary_selection" ];
        "C-h" = "select_prev_sibling";
        "C-l" = "select_next_sibling";
      };
    };

    # Language-specific settings (languages.toml)
    languages = {
      language = [
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "nix";
          formatter = { command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt"; };
          auto-format = true;
        }
      ];
    };
  };
}
