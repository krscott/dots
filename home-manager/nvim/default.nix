{pkgs, ...}: let
  # TODO: Why did I buildVimPlugin instead of using vimPlugins.nvim-nio ?
  nvim-nio = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-nio";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-neotest";
      repo = "nvim-nio";
      rev = "5800f585def265d52f1d8848133217c800bcb25d";
      sha256 = "0y3afl42z41ymksk29al5knasmm9wmqzby860x8zj0i0mfb1q5k5";
    };
  };

  # Script that uses the flake's formatter
  nix-any-fmt = pkgs.writeShellScriptBin "nix-any-fmt" ''
    formatter_path=$(nix build --json --dry-run --no-link .#formatter.x86_64-linux 2>/dev/null | jq -r '.[].outputs.out')

    if [ -z "$formatter_path" ]; then
        exit 1
    fi

    binary_name=$(ls $formatter_path/bin/)

    if [ -z "$binary_name" ]; then
        exit 1
    fi

    "$formatter_path/bin/$binary_name" "$@"
  '';
in {
  imports = [
    ./nvim-cloud-ai.nix
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

      # Debugging
      nvim-dap
      nvim-dap-ui
      nvim-nio # Required by nvim-dap-ui
      telescope-dap-nvim
      nvim-dap-virtual-text
      overseer-nvim # For .vscode/*.json support
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
      alejandra
      nil
      nixpkgs-fmt
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
