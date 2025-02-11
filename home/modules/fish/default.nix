{ lib
, config
, pkgs
, homeModules
, ...
}:

with lib;

let
  cfg = config.module.fish;
in {
  options = {
    module.fish.enable = mkEnableOption "Enables Fish";
  };

  imports = [
    "${homeModules}/fish/starship"
  ];

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting
        set fish_cursor_default     block      blink
        set fish_cursor_insert      line       blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual      block

        function fish_user_key_bindings
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase insert
        end
      '';

      plugins = [
        {
          name = "autopair";
          inherit (pkgs.fishPlugins.autopair) src;
        }
        {
          name = "done";
          inherit (pkgs.fishPlugins.done) src;
        }
      ];
    };
  };
}

