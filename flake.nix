# SPDX-License-Identifier: AGPL-3.0-or-later
#
# SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>
{
  description = "My personal website";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = import systems;

      imports = [
        inputs.git-hooks.flakeModule
        inputs.treefmt.flakeModule
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        treefmt = {
          projectRootFile = "flake.nix";

          programs = {
            alejandra.enable = true;
            prettier.enable = true;
            shfmt = {
              enable = true;
              indent_size = 4;
              simplify = true;
            };
          };

          settings = {
            formatter.shfmt.options = [
              "--case-indent"
              "--language-dialect"
              "bash"
            ];
          };
        };

        pre-commit.settings.hooks = {
          # markdownlint-cli2 reads .markdownlint-cli2.yaml from the repo root.
          # Defined as a custom hook because the predefined `markdownlint` hook
          # wraps markdownlint-cli (v1), which uses inline config instead.
          markdownlint-cli2 = {
            enable = true;
            name = "markdownlint-cli2";
            entry = "${pkgs.markdownlint-cli2}/bin/markdownlint-cli2";
            files = "\\.md$";
          };

          reuse.enable = true;
          treefmt.enable = true;
        };

        devShells.default = pkgs.mkShellNoCC {
          inputsFrom = [
            config.pre-commit.devShell
            config.treefmt.build.devShell
          ];

          packages = with pkgs; [
            hugo
            hut
            nixd
            openring
            tombi
            vscode-langservers-extracted
          ];
        };
      };
    });
}
