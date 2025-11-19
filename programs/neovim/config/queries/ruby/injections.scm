;; extends

;; Treat everything in the __END__ / `uninterpreted` section as ERB
;; if we have some Sinatra-style `@@` in there.
((uninterpreted) @injection.content
  (#contains? @injection.content "@@")
  (#set! injection.language "embedded_template")
  (#set! injection.include-children))
