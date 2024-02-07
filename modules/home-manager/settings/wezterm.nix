{ pkgs, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = /* lua */''
      local wezterm = require 'wezterm'
      local act = wezterm.action

      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- wezterm.gui is not available to the mux server, so take care to
      -- do something reasonable when this config is evaluated by the mux
      function get_appearance()
        if wezterm.gui then
          return wezterm.gui.get_appearance()
        end return 'Dark'
      end

      function scheme_for_appearance(appearance)
        if appearance:find 'Dark' then
          return 'Tokyo Night'
        else
          return 'Tokyo Night Day'
        end
      end

      config.color_scheme = scheme_for_appearance(get_appearance())

      -- I don't like putting anything at the ege if I can help it.
      config.enable_scroll_bar = false
      config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      }

      -- Equivalent to POSIX basename(3)
      -- Given "/foo/bar" returns "bar"
      -- Given "c:\\foo\\bar" returns "bar"
      function basename(s)
        return string.gsub(s, '(.*[/\\])(.*)', '%2')
      end

      wezterm.on(
        'format-tab-title',
        function(tab, tabs, panes, config, hover, max_width)
          local pane = tab.active_pane
          local title = pane.current_working_dir.file_path
          return {
            { Text = ' ' .. title .. ' ' },
          }
        end
      )

      config.use_fancy_tab_bar = false
      config.enable_tab_bar = true
      config.tab_bar_at_bottom = true

      config.font = wezterm.font 'ComicShannsMono Nerd Font Mono'
      config.font_size = 15.0
      -- config.font_size = 13.0

      config.send_composed_key_when_left_alt_is_pressed = true
      config.send_composed_key_when_right_alt_is_pressed = true

      return config
    '';
  };
}
