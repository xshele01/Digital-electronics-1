# Lab 5: Binary counter

## 1. Preparation task

The pushbuttons are connected to the FPGA via series resistors to prevent damage from inadvertent short circuits. 

The five pushbuttons arranged in a plus-sign configuration are “momentary” switches that normally generate a *low output when at rest*, and a *high output when pressed*.

The red pushbutton labeled ```CPU RESET```, on the other hand, generates a *high output when at rest* and a *low output when pressed*. The *CPU RESET* button is intended to be used in EDK designs to reset the processor, but you can also use it as a general purpose pushbutton.

Connection table:
| **Button** | **FPGA pin** |
| :-: | :-: |
| BTNL | P17 |
| BTNR | M17 |
| BTNU | M18 |
| BTND | P18 |
| BTNC | N17 |
| BTNRES| C12 |

Table with the number of periods of clock signal with frequency of 100 MHz in the span of 2 ms, 4 ms, 10 ms, 250 ms, 500 ms, and 1 s.
| **Time interval** | **Number of clk periods** | **Number of clk periods in hex** | **Number of clk periods in binary** |
| :-: | :-: | :-: | :-: |
| 2 ms | 200 000 | x"3_0d40" | b"0011_0000_1101_0100_0000" |
| 4 ms | 400 000 | x"6_1A80" | b"0110_0001_1010_1000_0000" |
| 10 ms | 1 000 000 | x"F_4240" | b"1111_0100_0010_0100_0000" |
| 250 ms | 25 000 000 | x"17D_7840" | b"0001_0111_1101_0111_1000_0100_0000" |
| 500 ms | 50 000 000 | x"2FA_F080" | b"0010_1111_1010_1111_0000_1000_0000" |
| 1 sec | 100 000 000 | x"5F5_E100" | b"0101_1111_0101_1110_0001_0000_0000" |