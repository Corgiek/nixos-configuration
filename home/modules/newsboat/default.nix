{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.newsboat;
in {
  options = {
    module.newsboat.enable = mkEnableOption "Enables newsboat tui rss reader";
  };

  config = mkIf cfg.enable {
    programs.newsboat = {
      enable = true;
      autoReload = true;
      maxItems = 0;

      urls = [
        {
          title = "Phoronix";
          tags = [
            "linux"
            "bsd" 
          ];
          url = "http://feeds.feedburner.com/Phoronix";
        }

        {
          title = "OpenNet";
          tags = [ 
            "linux"
            "bsd" 
          ];
          url = "http://www.opennet.ru/opennews/opennews_all.rss";
        }

        {
          title = "Nixpkgs News";
          tags = [ "nix" ];
          url = "https://nixpkgs.news/rss.xml";
        }

        {
          title = "Hacker News";
          tags = [ "hacking" ];
          url = "https://news.ycombinator.com/rss";
        }
      ];
    };
  };
}
