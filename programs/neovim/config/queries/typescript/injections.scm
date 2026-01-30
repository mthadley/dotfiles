;; extends

;; SQL tagged template literals: sql.*(...)`SELECT ...`
;; Matches: sql.type(...)`...`, sql.unsafe(...)`...`, sql.fragment(...)`...`, etc.
(call_expression
  function: (call_expression
    function: (member_expression
      object: (identifier) @_sql_id))
  arguments: (template_string
    (string_fragment) @injection.content)
  (#eq? @_sql_id "sql")
  (#set! injection.language "sql"))
