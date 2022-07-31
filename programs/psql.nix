{ ... }:

{
  home = {
    file.psqlrc = {
      text = ''
        \x auto
        \set PROMPT1 '%n@%m/%/ %R> '
        \set PROMPT2 '%l... %R> '
      '';
      target = ".psqlrc";
    };

  };
}
