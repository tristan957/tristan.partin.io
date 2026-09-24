# SPDX-License-Identifier: AGPL-3.0-or-later
#
# SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [./devenv-hugo.nix];

  treefmt = {
    enable = true;

    config = {
      projectRootFile = "devenv.nix";

      programs = {
        alejandra.enable = true;
        prettier.enable = true;
        shfmt = {
          enable = true;
          indent_size = 4;
          simplify = true;
        };
      };

      settings.formatter.shfmt.options = [
        "--case-indent"
        "--language-dialect"
        "bash"
      ];
    };
  };

  git-hooks.hooks = {
    # markdownlint-cli2 reads .markdownlint-cli2.yaml from the repo root.
    # Defined as a custom hook because the predefined `markdownlint` hook wraps
    # markdownlint-cli (v1), which uses inline config instead.
    markdownlint-cli2 = {
      enable = true;
      name = "markdownlint-cli2";
      entry = "${pkgs.markdownlint-cli2}/bin/markdownlint-cli2";
      files = "\\.md$";
    };

    reuse.enable = true;
    treefmt.enable = true;
  };

  tasks = {
    "openring:generate" = {
      exec =
        # bash
        "./scripts/openring/generate.sh";
    };

    "site:publish" = {
      exec =
        # bash
        ''
          hut pages publish
            --domain "$(echo "$DEVENV_TASK_INPUT" | jq --raw-output '.domain')"
          ${config.outputs.archive}
        '';
      input = {
        domain = "tristan.partin.io";
      };
    };
  };

  services.hugo.enable = true;

  outputs.site = pkgs.stdenvNoCC.mkDerivation {
    name = "tristan-partin-io";

    # Keep `.git` so Hugo's `enableGitInfo` can resolve each page's last
    # commit, but drop everything else that is either generated or unrelated
    # to the Hugo build.
    src = lib.cleanSourceWith {
      src = ./.;
      filter = path: _type:
        !(builtins.elem (baseNameOf path) [
          ".devenv"
          "public"
          "resources"
        ]);
    };

    nativeBuildInputs = [
      config.services.hugo.package
      pkgs.gitMinimal
    ];

    dontConfigure = true;

    buildPhase = ''
      runHook preBuild

      hugo --minify --gc

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      cp -r public "$out"

      runHook postInstall
    '';
  };

  outputs.archive = pkgs.runCommand "tristan-partin-io.archive" {} ''
    tar -C ${config.outputs.site} -czf "$out" .
  '';

  packages = with pkgs; [
    hut
    nixd
    openring
    tombi
    vscode-langservers-extracted
  ];
}
