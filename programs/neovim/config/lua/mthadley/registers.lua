local registers = require "registers"

registers.setup {
	window = {
		border = "shadow",
		transparency = 0,
	},

	bind_keys = {
		-- The default `registers` passes `{ delay = 0.1 }`. This
		-- overrides it to remove that delay and the perceptable
		-- input lag it causes.
		registers = registers.apply_register(),
	},
}
