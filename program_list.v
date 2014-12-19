80                      // 80430000     LOOP:   LD R3, 0(R2)            | Load R3 with word DATAMEM[ R2]
43
00
00
20                      // 2021FFFF             ADDI  R1, R1, #-1       | Count down R1 from initial value to 0
21
FF
FF
00                      // 00000000             NOP
00
00
00
00                      // 00030020             ADD  R0, R0, R3         | Update R0 with DATAMEM[R2]
03
00
20
10                      // 10240024             BEQ     R1, R4, DONE    | When count R1 reeaches 0, quit
24
00
04
20                      // 20420004             ADDI    R2, R2, 4       | Update index variable to next element of arary
42
00
04
00                      // 00000000             NOP
00
00
00
00                      // 00000000             NOP
00
00
00
10                      // 10C6FFF7             BEQ     R6, R6, LOOP    | Always loop back to start
C6
FF
F7
00                      // 00000000     DONE:   NOP
00
00
00
00                      // 00000000             NOP
00
00
00
00                      // 00000000             NOP
00
00
00
00                      // 00000000             NOP
00
00
00
00                      // 00000000             NOP
00
00
00
00                      // 00000000             NOP
00
00
00
00                      // 00000000             NOP
00
00
00

