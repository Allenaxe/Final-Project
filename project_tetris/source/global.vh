//Speaker
`define DIV_BY_25K 25_000
`define DIV_BY_25K_BIT_WIDTH 15
`define DIV_BY_TWO 2'd2
`define DIV_BY_FOUR 2'd2
`define DIV_BY_128 7'd64
`define DIV_BY_TWO_BIT_WIDTH 2
`define DIV_BY_FOUR_BIT_WIDTH 2
`define DIV_BY_128_BIT_WIDTH 7

// The width of the screen in pixels
`define SCREEN_WIDTH_PIXEL 640
// The height of the screen in pixels
`define SCREEN_HEIGHT_PIXEL 480

// Used for VGA horizontal and vertical sync
`define HSYNC_FRONT_PORCH 16
`define HSYNC_PULSE_WIDTH 96
`define HSYNC_BACK_PORCH 48
`define VSYNC_FRONT_PORCH 10
`define VSYNC_PULSE_WIDTH 2
`define VSYNC_BACK_PORCH 33

// keyboard
`define KEY_UP 9'h175
`define KEY_DOWN 9'h172
`define KEY_LEFT 9'h16B
`define KEY_RIGHT 9'h174
`define KEY_W 9'h1D
`define KEY_A 9'h1C
`define KEY_S 9'h1B
`define KEY_D 9'h23
`define KEY_SPACE 9'h29

// How many pixels wide/high each block is
`define BLOCK_SIZE_PIXEL 20

// How many blocks wide the game board is
`define BOARD_WIDTH_BLK 10

// How many blocks high the game board is
`define BOARD_HEIGHT_BLK 22

// Width of the game board in pixels
`define BOARD_WIDTH_PIXEL (`BOARD_WIDTH_BLK * `BLOCK_SIZE_PIXEL)
// Starting x pixel for the game board
`define BOARD_X_START_PIXEL (((`SCREEN_WIDTH_PIXEL - `BOARD_WIDTH_PIXEL) / 2) - 1)

// Height of the game board in pixels
`define BOARD_HEIGHT_PIXEL (`BOARD_HEIGHT_BLK * `BLOCK_SIZE_PIXEL)
// Starting y pixel for the game board
`define BOARD_Y_START_PIXEL (((`SCREEN_HEIGHT_PIXEL - `BOARD_HEIGHT_PIXEL) / 2) - 1)

// The number of bits used to store a block position
`define BITS_BLK_POS 8
// The number of bits used to store an X position
`define BITS_X_POS 4
// The number of bits used to store a Y position
`define BITS_Y_POS 5
// The number of bits used to store a rotation
`define BITS_ROT 2
// The number of bits used to store how wide / long a block is (max of decimal 4)
`define BITS_BLK_SIZE 3
// The number of bits for the score. The score goes up to 10000
`define BITS_SCORE 14
// The number of bits used to store each block
`define BITS_PER_BLOCK 3

// The type of each block
`define BLOCK_EMPTY 3'b000
`define BLOCK_I 3'b001
`define BLOCK_O 3'b010
`define BLOCK_T 3'b011
`define BLOCK_S 3'b100
`define BLOCK_Z 3'b101
`define BLOCK_J 3'b110
`define BLOCK_L 3'b111

// Color mapping. {red[3:0], green[3:0], blue[3:0]}
`define WHITE 12'b1111_1111_1111
`define BLACK 12'b0000_0000_0000
`define GRAY 12'b1000_1000_1000
`define CYAN 12'b0000_1111_1111
`define YELLOW 12'b1111_1111_0000
`define MAGENTA 12'b1111_0000_1111
`define GREEN 12'b0000_1111_0000
`define RED 12'b1111_0000_0000
`define BLUE 12'b0000_0000_1111
`define ORANGE 12'b1111_1000_0000
`define DARK_GRAY 12'b0111_0111_0111

// Error value. 
`define ERR_BLK_POS 8'b1111_1111

// Modes
`define BITS_MODE 2
`define MODE_IDLE 0
`define MODE_PLAY 1
`define MODE_PAUSE 2

// The maximum value of the drop timer
`define DROP_TIMER_MAX 10000

// fall speed
`define SPEED_SLOW 0
`define SPEED_NORMAL 1
`define SPEED_FAST 2