{pkgs, ...}: let
  # TODO(kscott): Move to separate sh file
  # Script that uses the flake's formatter
  # Note: `nix eval --raw .#formatter.x86_64-linux` also works to find
  #   formatter_path, but is slower
  nix-any-fmt = pkgs.writeShellScriptBin "nix-any-fmt" ''
    while getopts ":s:" opt; do
      case $opt in
        s)
          session_file="$OPTARG"
          if [ -s "$session_file" ]; then
            nixfmt_binary="$(cat "$session_file")"
          fi
          ;;
        \?)
          echo "Invalid option: -$OPTARG" >&2
          exit 1
          ;;
        :)
          echo "Option -$OPTARG requires an argument." >&2
          exit 1
          ;;
      esac
    done
    shift $((OPTIND-1))

    if [ -z "$nixfmt_binary" ]; then
      system="$(nix eval --impure --raw --expr 'builtins.currentSystem' 2>/dev/null)"
      formatter_path=$(nix build --json --dry-run --no-link ".#formatter.$system" 2>/dev/null | jq -r '.[].outputs.out')

      if [ -z "$formatter_path" ]; then
          echo >&2 "No formatter set in flake"
          exit 1
      fi

      nixfmt_binaries=( "$formatter_path"/bin/* )
      nixfmt_binary="''${nixfmt_binaries[0]}"

      if [ -z "$nixfmt_binary" ]; then
          echo >&2 "No formatter nixfmt_binary found"
          exit 1
      fi

      if [ ! -z "$session_file" ]; then
        echo "$nixfmt_binary" > "$session_file"
      fi
    fi

    "$nixfmt_binary" "$@"
  '';
in {
  imports = [
    ./nvim-cloud-ai.nix
  ];

  home.packages = [
    nix-any-fmt
  ];

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-sensible
      obsidian-nvim

      # Nav/UI
      harpoon
      telescope-nvim
      trouble-nvim
      undotree
      vim-tmux-navigator
      which-key-nvim

      # Editing
      nvim-autopairs
      tabout-nvim
      vim-commentary
      vim-sleuth
      nvim-surround

      # File Tree
      neo-tree-nvim
      #nvim-tree-lua
      nvim-web-devicons

      # Git
      vim-fugitive
      lazygit-nvim

      # Parsing/Highlighting
      nvim-treesitter.withAllGrammars
      todo-comments-nvim
      vim-illuminate
      vim-better-whitespace

      # LSP
      lsp-zero-nvim
      nvim-lspconfig
      cmp-nvim-lsp
      nvim-cmp
      neodev-nvim # TODO: EOL, switch to lazydev.nvim?
      otter-nvim # Embedded code LSP

      # Formatter
      lsp-format-nvim # For formatter shims

      # Language-Specific
      cmp_luasnip
      luasnip
      gleam-vim
      rustaceanvim
      cmake-tools-nvim
      vim-jinja

      # Debugging
      nvim-dap
      nvim-dap-ui
      nvim-nio # Required by nvim-dap-ui
      telescope-dap-nvim
      nvim-dap-virtual-text
      overseer-nvim # For .vscode/*.json support

      neotest
      neotest-gtest
    ];

    extraPackages = with pkgs; [
      tree-sitter
      nodejs

      # telescope-nvim
      ripgrep
      fd
      # lazygit-nvim
      lazygit

      # Language Servers
      # (:help lspconfig-all)
      # Note: Don't forget to add lsp.<lang>.setup() in `lsp.lua`!
      efm-langserver # For shims

      # Bash
      nodePackages.bash-language-server
      #shellcheck
      shfmt
      # C
      clang
      # Gleam
      gleam
      # Go
      golangci-lint-langserver
      gopls
      # Lua
      lua-language-server
      # Nix
      nix-any-fmt
      nil
      statix
      # Python
      pyright
      ruff
      ruff-lsp
      # Rust
      rust-analyzer
      rustfmt
      # Typescript
      nodePackages.typescript-language-server
      # Web (ESLint, HTML, CSS, JSON)
      nodePackages.vscode-langservers-extracted

      # Debugging
      lldb
    ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
