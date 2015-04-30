# Force syntax highlighting of one type to another

forceGrammar = (from, to) ->
	atom.workspace.observeTextEditors (editor) ->
		grammar = editor.getGrammar()

		if grammar and grammar.scopeName is from
			editor.setGrammar atom.grammars.grammarForScopeName(to)

forceGrammar 'source.css', 'source.css.scss'

# Highlight <aui:script> blocks

scriptGrammar = atom.grammars.grammarForScopeName('text.html.basic')

if scriptGrammar
	for pattern in scriptGrammar.rawPatterns
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
else
	atom.notifications.addWarning 'Warning: Did not update HTML Grammar'