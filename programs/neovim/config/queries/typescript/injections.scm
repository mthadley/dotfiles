;; extends

;; SQL tagged template literals
;; Matches: sql.unsafe`...`, sql.type(...)`...`, etc.
(call_expression
  function: [
    (member_expression
      object: (identifier) @_sql_id)
    (call_expression
      function: (member_expression
        object: (identifier) @_sql_id))
  ]
  arguments: (template_string
    (string_fragment) @injection.content)
  (#eq? @_sql_id "sql")
  (#set! injection.language "sql"))
