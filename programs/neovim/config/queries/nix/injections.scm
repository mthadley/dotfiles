;; extends

;; Detected embedded file contents for Nix expressions
;; of the form:
;;
;;   home.file.'some/path.toml'.text = ''
;;     foo = "bar"
;;   ''
;;
(binding
  attrpath: (attrpath
    attr: (identifier ) @key.file
    attr: (string_expression
      (string_fragment) @injection.filename)
    attr: (identifier) @key.text)
  expression: (
    indented_string_expression (
      (string_fragment) @injection.content))
  (#eq? @key.file "file")
  (#eq? @key.text "text")
)
