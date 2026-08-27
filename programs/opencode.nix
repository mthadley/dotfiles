{ llmPkgs, ... }:

{
  home.packages = with llmPkgs; [ opencode ];

  xdg.configFile."opencode/tui.jsonc".text = ''
    {
      "$schema": "https://opencode.ai/tui.json",
      "theme": "nord",
    }
  '';
}
