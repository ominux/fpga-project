Version 4
SymbolType BLOCK
TEXT 32 32 LEFT 4 divisor_fifo
RECTANGLE Normal 32 32 544 768
LINE Wide 0 80 32 80
PIN 0 80 LEFT 36
PINATTR PinName din[15:0]
PINATTR Polarity IN
LINE Normal 0 144 32 144
PIN 0 144 LEFT 36
PINATTR PinName wr_en
PINATTR Polarity IN
LINE Normal 0 176 32 176
PIN 0 176 LEFT 36
PINATTR PinName wr_clk
PINATTR Polarity IN
LINE Normal 0 240 32 240
PIN 0 240 LEFT 36
PINATTR PinName rd_en
PINATTR Polarity IN
LINE Normal 0 272 32 272
PIN 0 272 LEFT 36
PINATTR PinName rd_clk
PINATTR Polarity IN
LINE Normal 144 800 144 768
PIN 144 800 BOTTOM 36
PINATTR PinName rst
PINATTR Polarity IN
LINE Wide 576 80 544 80
PIN 576 80 RIGHT 36
PINATTR PinName dout[15:0]
PINATTR Polarity OUT
LINE Normal 576 208 544 208
PIN 576 208 RIGHT 36
PINATTR PinName full
PINATTR Polarity OUT
LINE Normal 576 432 544 432
PIN 576 432 RIGHT 36
PINATTR PinName empty
PINATTR Polarity OUT

