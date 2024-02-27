{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.gh.enable = mkEnableOption "GitHub CLI";

  config = mkIf config.gearshift.gh.enable {
    home-manager.users."${config.gearshift.username}" = {
      home.packages = with pkgs; [ gh-eco gh-f ];
      programs.gh-dash = {
        enable = true;
        settings = {
          prSections = [
            {
              title = "My Pull Requests";
              filters = "is:open author:@me";
              layout = {
                author = {
                  hidden = true;
                  # width = <number of columns>;
                  # grow = <bool> this will make the column grow in size;
                };
              };
            }
            {
              title = "Needs My Review";
              filters = "is:open review-requested:@me";
            }
          ];
          issuesSections = [
            {
              title = "Created";
              filters = "is:open author:@me";
            }
            {
              title = "Assigned";
              filters = "is:open assignee:@me";
            }
          ];
          defaults = {
            layout = {
              prs = {
                repo = {
                  grow = true;
                  width = 10;
                  hidden = false;
                };
              };
              # issues = same structure as prs;
            };
            prsLimit = 20; # global limit
            issuesLimit = 20; # global limit
            preview = {
              open = true; # whether to have the preview pane open by default
              width = 60; # width in columns
            };
            refetchIntervalMinutes =
              30; # will refetch all sections every 30 minutes
          };
          # keybindings = {}; # optional, define custom keybindings - see more info below
          # theme = {}; # optional, see more info below
          pager = {
            diff = "bat --pager less"; # or delta for example
          };
        };
      };
    };
  };
}
