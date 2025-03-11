{...}: {
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        #Plugins
        navigation.harpoon = {
                    enable = true;
                };
        lsp = {
          enable = true;
          formatOnSave = false;
          lightbulb.enable = true;
          lspSignature.enable = true;
          # lsplines.enable = true;
          trouble.enable = true;
        };

        languages = {
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableLSP = true;
          enableTreesitter = true;
          assembly.enable = true;
          rust.enable = true;
          java.enable = true;
          csharp.enable = true;
          nix.enable = true;
          markdown.enable = true;
          bash.enable = true;
          python.enable = true;
          tailwind.enable = true;
          ts.enable = true;
        };

        autocomplete.nvim-cmp = {
          enable = true;
        };

        autopairs.nvim-autopairs = {
          enable = true;
        };

        binds = {
          cheatsheet.enable = true;
          whichKey.enable = true;
        };

        comments.comment-nvim.enable = true;

        debugger.nvim-dap = {
          enable = true;
        };

        filetree = {
          # neo-tree.enable = true;
        };

        git.enable = true;

        minimap.codewindow.enable = true;

        runner.run-nvim.enable = true;

        snippets.luasnip.enable = true;

        statusline.lualine.enable = true;

        telescope.enable = true;

        treesitter = {
          enable = true;
          addDefaultGrammars = true;
          autotagHtml = true;
        };

        utility = {
          diffview-nvim.enable = true;
          icon-picker.enable = true;
          # images.image-nvim.enable = true;
          preview.markdownPreview = {
            enable = true;
            autoStart = true;
          };
          yanky-nvim.enable = true;
          motion = {
            precognition.enable = true;
          };
        };

        visuals = {
          cellular-automaton.enable = true;

          fidget-nvim = {
            enable = true;
            setupOpts.progress.display = {
              done_ttl = 4;
              progress_icon.pattern = "grow_horizontal";
            };
          };

          cinnamon-nvim = {
            enable = true;
            setupOpts.options = {
              time = 250; # Maximum smooth scroll time
            };
          };

          nvim-cursorline.enable = true;
          nvim-web-devicons.enable = true;
        };

        #Plugins END

        #Settings
        useSystemClipboard = true; # Try it out, if annoying remove

        undoFile = {
          enable = true;
          path = ''/home/myUser/.vim/undodir'';
        };

        # theme = {
        #   enable = true;
        #   name = "gruvbox";
        #
        #   style = "dark";
        # };

        syntaxHighlighting = true;

        hideSearchHighlight = true;

        options = {
          cursorlineopt = "line";
          shiftwidth = 4;
          tabstop = 4;
          updatetime = 100; # Set lower if Cursor Hold is too fast
          wrap = false;
        };

        #Settings END

        #Keymaps

        keymaps = [
        ];

        #Keympas END
      };
    };
  };
}
