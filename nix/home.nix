{ inputs, lib, config, pkgs, ... }:

{
  imports = [ inputs.nixcord.homeModules.nixcord ];
  
  home.username = "stellaaash";
  home.homeDirectory = "/home/stellaaash";

  home.packages = with pkgs; [
    kdePackages.kate

    # Browser
    vivaldi
    firefox

    # Utilities
    obsidian
    vlc

    # Games
    prismlauncher
    itch

    # Editors
    zed-editor

    # Arduion
    arduino-cli
    arduino-ide

    # Terminal emulator
    ghostty
  ];

  programs.git = {
    enable = true;
    settings.user.name = "Aisling Fontaine";
    settings.user.email = "aisling.fontaine@protonmail.com";
    settings.pull.rebase = true;
    settings.init.defaultbranch = "main";
  };

  programs.helix = {
    settings = {
      theme = "everforest_dark";
    };
  };

  programs.zed-editor = {
    enable = true;

    extensions = [
      "everforest"
    ];

    userSettings = {
      helix_mode = true;
      colorize_brackets = true;
      disable_ai = true;

      git_panel = {
        tree_view = true;
        collapse_untracked_diff = true;
        sort_by_path = false;
      };

      project_panel = {
        entry_spacing = "standard";
      };

      bottom_dock_layout = "full";

      preview_tabs = {
        enable_preview_from_file_finder = false;
      };

      tab_bar = {
        show = true;
      };

      title_bar = {
        show_menus = false;
        show_branch_icon = true;
      };

      search = {
        case_sensitive = true;
      };

      indent_guides = {
        background_coloring = "disabled";
        coloring = "indent_aware";
        active_line_width = 2;
        line_width = 1;
      };

      scroll_beyond_last_line = "vertical_scroll_margin";
      current_line_highlight = "all";
      cursor_shape = "bar";
      ui_font_weight = 400.0;
      restore_on_startup = "last_session";

      outline_panel = {
        dock = "left";
      };

      show_edit_predictions = false;
      ui_font_size = 16;
      buffer_font_size = 13.0;

      theme = {
        mode = "system";
        light = "Catppuccin Latte";  # TODO
        dark = "Everforest Dark Medium (material)";
      };

      # icon_theme = "Catppuccin Mocha";  # TODO
      relative_line_numbers = "enabled";

      active_pane_modifiers = {
        border_size = 0.5;
        inactive_opacity = 0.6;
      };

      diagnostics = {
        button = true;
        include_warnings = true;
        inline = {
          enabled = true;
          update_debounce_ms = 150;
          padding = 4;
          min_column = 0;
          max_severity = null;
        };
      };

      inlay_hints = {
        show_background = true;
        enabled = false;
        toggle_on_modifiers_press = {
          alt = true;
        };
      };

      minimap = {
        thumb_border = "right_open";
        thumb = "always";
        show = "auto";
        display_in = "active_editor";
      };

      tabs = {
        file_icons = true;
        git_status = true;
        show_diagnostics = "all";
      };

      toolbar = {
        code_actions = true;
      };

      base_keymap = "VSCode";

      terminal = {
        toolbar = {
          breadcrumbs = false;
        };
        dock = "right";
        line_height = "standard";
      };

      wrap_guides = [ 80 100 ];
      soft_wrap = "editor_width";
      show_whitespaces = "all";

      which_key = {
        enabled = true;
      };

      git = {
        blame = {
          show_avatar = true;
        };
        inline_blame = {
          enabled = true;
          delay_ms = 500;
          show_commit_summary = true;
          min_column = 80;
        };
      };

      file_types = {
        "C" = [ "c" "h" ];
        "C++" = [ "cpp" "hpp" "tpp" ];
        "Zig" = [ "zig" ];
      };

      languages = {
        "Shell Script" = {
          show_edit_predictions = false;
        };
        "YAML" = {
          show_edit_predictions = false;
        };
        "C" = {
          show_edit_predictions = false;
        };
        "C++" = {
          show_edit_predictions = false;
          format_on_save = "on";
        };
        "Rust" = {
          show_edit_predictions = false;
          format_on_save = "on";
        };
        "HTML" = {
          tab_size = 2;
        };
        "CSS" = {
          tab_size = 2;
        };
      };
    };
  };

  # Discord
  programs.nixcord = {
    enable = true;

    discord.vencord.enable = true;

    # https://flameflag.github.io/nixcord/
    config = {
      # Theme
      themeLinks = [
        "https://raw.githubusercontent.com/7eahaus/everforest/refs/heads/main/teaforest.theme.css"
      ];
      frameless = true;

      plugins = {
        betterFolders = {
          enable = true;
          showFolderIcon = 0;
        };
        betterSessions.enable = true;
        betterUploadButton.enable = true;
        BlurNSFW.enable = true;
        biggerStreamPreview.enable = true;
        dearrow.enable = true;
        favoriteGifSearch.enable = true;
        LastFMRichPresence.enable = true;
      };
    };
  };
  
  home.stateVersion = "26.05";

}
