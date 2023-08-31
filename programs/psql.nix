{
  home.file.".psqlrc".text = ''
    \x auto
    \pset linestyle unicode
    \set PROMPT1 '%n@%m/%/ %R> '
    \set PROMPT2 '%w'
    \set COMP_KEYWORD_CASE upper
  '';
}
