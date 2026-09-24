# SPDX-License-Identifier: AGPL-3.0-or-later
#
# SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>
{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.services.hugo;

  parsePort = addr: lib.toInt (lib.last (lib.splitString ":" addr));
  parseHost = addr: lib.head (lib.splitString ":" addr);

  basePort = parsePort cfg.listenAddress;
  allocatedPort = config.processes.hugo.ports.main.value;
  host = parseHost cfg.listenAddress;
in {
  options.services.hugo = {
    enable = lib.mkEnableOption "Hugo development server";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hugo;
      defaultText = lib.literalExpression "pkgs.hugo";
      description = "The hugo package to use.";
    };

    listenAddress = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1:1313";
      description = "Listen address for the Hugo development server.";
    };

    baseURL = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = ''
        Base URL passed to `hugo server --baseURL`. Uses Hugo's own default
        when null.
      '';
    };

    buildDrafts = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to include draft content (`--buildDrafts`).";
    };

    extraArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional arguments passed to `hugo server`.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [cfg.package];

    processes.hugo.ports.main.allocate = basePort;
    processes.hugo.exec = ''
      exec ${cfg.package}/bin/hugo server \
        --bind ${lib.escapeShellArg host} \
        --port ${toString allocatedPort} \
        ${lib.optionalString cfg.buildDrafts "--buildDrafts"} \
        ${lib.optionalString (cfg.baseURL != null) "--baseURL ${lib.escapeShellArg cfg.baseURL}"} \
        ${lib.escapeShellArgs cfg.extraArgs}
    '';
  };
}
