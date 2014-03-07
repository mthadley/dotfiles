/* The height of the bar (in pixels) */
#define BAR_HEIGHT  20
/* The width of the bar. Set to -1 to fit screen */
#define BAR_WIDTH   -1
/* Offset from the left. Set to 0 to have no effect */
#define BAR_OFFSET 0 
/* Choose between an underline or an overline */
#define BAR_UNDERLINE 1
/* The thickness of the underline (in pixels). Set to 0 to disable. */
#define BAR_UNDERLINE_HEIGHT 3
/* Default bar position, overwritten by '-b' switch */
#define BAR_BOTTOM 0
/* The fonts used for the bar, comma separated. Only the first 2 will be used. */
#define BAR_FONT       "-*-terminus-medium-*-*-*-14-*-*-*-*-*-iso10646-*","fixed"
/* Some fonts don't set the right width for some chars, pheex it */
#define BAR_FONT_FALLBACK_WIDTH 6
/* Define the opacity of the bar (requires a compositor such as compton) */
#define BAR_OPACITY 1.0 /* 0 is invisible, 1 is opaque */
/* Color palette */
#define BACKGROUND 0x141414 // Black
#define COLOR0 0x4D4D4D		// Black
#define COLOR1 0xBF4D80		// Red
#define COLOR2 0x53A6A6		// Green
#define COLOR3 0xA270A3 	// Yellow
#define COLOR4 0x477AB3		// Blue
#define COLOR5 0xa7E62B3	// Magenta
#define COLOR6 0x6096BF		// Cyan
#define COLOR7 0xe0e0e0		// Grey
#define COLOR8 0x575757		// white
#define COLOR9 0xCC739B		// Red
#define FOREGROUND 0x696969 // grey

#define XINERAMA 1
