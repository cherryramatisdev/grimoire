{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = "Monaco";
      font.size = 15;
    };
  };
}
