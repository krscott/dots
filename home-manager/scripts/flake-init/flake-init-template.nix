# flake.nix template
# Kris Scott
#
# How to use:
# 1. Update description and pname
# 2. Uncomment commented code lines and update as needed
# 3. Delete this how-to comment
{
  description = "TODO";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pname = "my-prog";
    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = function:
      nixpkgs.lib.genAttrs supportedSystems (
        system:
          function {
            inherit system;
            pkgs = import nixpkgs {inherit system;};
          }
      );
  in {
    packages = forAllSystems (
      {pkgs, ...}: {
        default = pkgs.clangStdenv.mkDerivation {
          inherit pname;
          version = "0.1.0";
          src = ./.;

          # nativeBuildInputs = with pkgs; [
          #   cmake
          #   meson
          #   ninja
          #   pkg-config
          #   clang-tools
          # ];

          # buildInputs = [ ];

          # configurePhase = ''
          #   meson build
          # '';

          # buildPhase = ''
          #   (
          #     cd build
          #     meson compile
          #   )
          # '';

          # installPhase = ''
          #   mkdir -p $out/bin
          #   cp build/src/${pname} $out/bin
          # '';
        };
      }
    );

    apps = forAllSystems ({system, ...}: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/${pname}";
      };
    });

    # devShells = forAllSystems ({ system, pkgs, ... }:
    #   let
    #     llvm = pkgs.llvmPackages_latest;
    #   in {
    #     default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
    #       packages = with pkgs; self.packages.${system}.default.nativeBuildInputs ++ [
    #         # debugger
    #         llvm.lldb
    #         gdb

    #         # fix headers not found
    #         clang-tools

    #         # LSP and compiler
    #         llvm.libstdcxxClang

    #         # other tools
    #         cppcheck
    #         llvm.libllvm
    #         valgrind

    #         # stdlib for cpp
    #         llvm.libcxx
    #       ];
    #     };
    #   });
  };
}
