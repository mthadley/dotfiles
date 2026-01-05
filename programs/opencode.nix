{ llmPkgs, ... }:

{
  home.packages = with llmPkgs; [ opencode ];

  xdg.configFile."opencode/opencode.jsonc".text = ''
    {
      "$schema": "https://opencode.ai/config.json",
      "theme": "nord",
    }
  '';
}
