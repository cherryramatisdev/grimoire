{ pkgs, ... }: {
  programs.starship = {
    enable = false;
    settings = {
      scan_timeout = 10;
      add_newline = false;
      character = {
        success_symbol = "[🍒](bold green)";
        error_symbol = "[🍒](bold red)";
      };
      custom.gh_profile = {
        command = "gh_current_active_account";
        symbol = "🎋 ";
        style = "bold white";
        when = true;
      };
      package = {
        disabled = true;
      };
    };
  };
}
