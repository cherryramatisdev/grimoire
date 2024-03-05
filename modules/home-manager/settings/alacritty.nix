{ pkgs, ... }: {
  programs.alacritty = {
    enable = false;
    settings = {
      font.normal.family = "ComicShannsMono Nerd Font";
      font.size = 15;
    };
  };
}
