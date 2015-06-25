# Force syntax highlighting of one type to another

forceGrammar = (from, to) ->
	atom.workspace.observeTextEditors (editor) ->
		grammar = editor.getGrammar()

		if grammar and grammar.scopeName is from
			editor.setGrammar atom.grammars.grammarForScopeName(to)

forceGrammar 'source.css', 'source.css.scss'

# Highlight <aui:script> blocks

updateHTMLGrammar = (grammar) ->
	for pattern in grammar.rawPatterns
		if pattern.name is 'source.js.embedded.html'
			# Original: '(?:^\\s+)?(<)((?i:script))\\b(?![^>]*/>)'
			pattern.begin = '(?:^\\s+)?(<)((?i:(aui:)?script))\\b(?![^>]*/>)'

			# Original: '(?<=</(script|SCRIPT))(>)(?:\\s*\\n)?'
			pattern.end = '(?<=</(script|SCRIPT))|(?<=</aui:script)(>)(?:\\s*\\n)?'

			subPattern = pattern.patterns[1]

			# Original: '(?<!</(?:script|SCRIPT))(>)'
			subPattern.begin = '(?<!</(?:script|SCRIPT))|(?<!</aui:script)(>)'

			# Original: '(</)((?i:script))'
			subPattern.end = '(</)((?i:(aui:)?script))'

			break

loadedGrammar = atom.grammars.grammarForScopeName('text.html.basic')

if loadedGrammar
	updateHTMLGrammar loadedGrammar
else
	atom.grammars.onDidAddGrammar (grammar) ->
		updateHTMLGrammar grammar if grammar.scopeName is 'text.html.basic'