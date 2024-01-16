{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = "ComicShannsMono Nerd Font";
      font.size = 15;
    };
  };
}
