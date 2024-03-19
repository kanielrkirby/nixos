{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    programs.starship.settings = {
      format =
        "$username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$vlang$vagrant$zig$buf$nix_shell$conda$meson$spack$memory_usage$aws$gcloud$openstack$azure$env_var$crystal$custom$sudo$cmd_duration$line_break$jobs$battery$time$status$os$container$shell$character";
      scan_timeout = 10;

      add_newline = false;

      cmd_duration = {
        min_time = 500;
        format = "underwent [$duration](bold yellow)";
      };

      container = { format = "[$symbol [$name]]($style) "; };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "green bold dimmed";
        truncation_length = 1;
        truncation_symbol = "»/";
      };

      docker_context = { format = "via [🐋 $context](blue bold)"; };

      dotnet = {
        symbol = "🥅 ";
        style = "green";
        heuristic = false;
      };

      fill = {
        symbol = "-";
        style = "bold green";
      };

      fossil_branch = {
        symbol = "🦎 ";
        truncation_length = 4;
        truncation_symbol = "";
      };

      git_branch = {
        symbol = "🌱 ";
        truncation_length = 4;
        truncation_symbol = "";
        ignore_branches = [ "master" "main" ];
      };

      git_commit = {
        commit_hash_length = 4;
        tag_symbol = "🔖 ";
      };

      git_state = {
        format = "[($state( $progress_current of $progress_total))]($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };

      git_metrics = {
        added_style = "bold blue";
        format = "[+$added]($added_style)/[-$deleted]($deleted_style) ";
      };

      git_status = {
        conflicted = "C";
        ahead = "↑";
        behind = "↓";
        diverged = "↕";
        up_to_date = "✔";
        untracked = "??";
        stashed = "S";
        modified = "M";
        staged = "[++($count)](green)";
        renamed = "R";
        deleted = "D";
      };

      golang = { format = "[Go:$version](bold cyan) "; };

      hostname = {
        ssh_only = true;
        format = "[$ssh_symbol](bold blue) on [$hostname](bold red) ";
        trim_at = ".companyname.com";
        disabled = false;
      };

      line_break = { disabled = true; };

      localip = {
        ssh_only = true;
        format = "@[$localipv4](bold red) ";
        disabled = false;
      };

      lua = { format = "via [🌕 $version](bold blue) "; };

      memory_usage = {
        disabled = true;
        threshold = -1;
        symbol = " ";
        style = "bold dimmed green";
      };

      nodejs = { format = "via [🤖 $version](bold green) "; };

      os = {
        format = "on [($name )]($style)";
        style = "bold blue";
        disabled = true;
      };

      package = { format = "via [🎁 $version](208 bold) "; };

      python = { python_binary = "python3"; };

      shell = { disabled = true; };

      sudo = {
        style = "bold green";
        symbol = "sudo ";
        disabled = false;
      };

      time = {
        disabled = true;
        format = "🕙[[ $time ]]($style) ";
        time_format = "%T";
        utc_time_offset = "-5";
        time_range = "10:00:00-14:00:00";
      };

      username = {
        disabled = true;
        style_user = "white bold";
        style_root = "black bold";
        format = "[$user]($style) ";
        show_always = true;
      };
    };
  };
}
