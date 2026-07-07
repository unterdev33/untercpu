# untercpu

a tiny educational virtual CPU written in lua with its own instruction set, assembler, and machine code format.

```text
main.uasm -> assembler -> ucpu/main.ucpu -> virtual CPU -> program output
```

## features

* custom instruction set (ISA)
* assembler
* virtual CPU
* custom machine code format (`.ucpu`)
* 4 general-purpose registers
* 256 bytes of memory
* fixed-size instructions (3 bytes)

## requirements

* lua 5.3+

## installation

clone the repository:

```bash
git clone https://github.com/unterdev33/untercpu
cd untercpu
```
make untercpu executable:

```bash
chmod -x untercpu
```
## project structure

```text
├── assembler.lua
├── build.lua
├── cpu.lua
├── run.lua
├── untercpu
├── ucpu/
├── main.uasm
└── README.md
```

## usage

build an assembly program:

```bash
./untercpu build main.uasm
```

the compiled program will be saved as:

```text
ucpu/main.ucpu
```
-----------------------
run a compiled program:

```bash
./untercpu run main
```

build and immediately run a program:

```bash
./untercpu start main.uasm
```

display help:

```bash
./untercpu help
```

## example

assembly source:

```asm
MOV R0 72
PRINT R0

MOV R0 105
PRINT R0

HALT
```

build:

```bash
./untercpu build hello.uasm
```

run:

```bash
./untercpu run hello
```

Output:

```text
Hi
```

## architecture

### registers

```text
R0
R1
R2
R3
```

`R3` is reserved for the result of the `CMP` instruction.

### memory

```text
256 bytes
```

memory stores both instructions and program data.

### instruction format

each instruction occupies exactly three bytes.

```text
OPCODE ARG1 ARG2
```

example:

```text
2 0 72
```

is equivalent to:

```asm
MOV R0 72
```

## instruction set

**ISA available on google sheets:** https://docs.google.com/spreadsheets/d1mtu_ajOosjGi8C20cFWCVu4Y1kvMKEs9cEdgPnMOWeI/

| Opcode | Mnemonic | Description |
|--------:|----------|-------------|
| 1 | HALT | halts cpu |
| 2 | MOV | write the immediate value to the register (reg). |
| 3 | ADD | addition of the values ​​in registers R1 and R2, with the result stored in R1. |
| 4 | SUB | substraction of the values ​​in registers R1 and R2, with the result stored in R1. |
| 5 | JMP | unconditional jump. |
| 6 | JNZ | jump to address if the specified register is not zero. |
| 7 | PRINT | print the ascii character whose code is stored in the register. |
| 8 | XOR | bitwise xor of R1 and R2. the result is stored in R1. |
| 9 | SHL | shift the value in reg left by the specified number of bits. |
| 10 | SHR | shift the value in reg right by the specified number of bits. |
| 11 | MUL | multiply R1 by R2. the result is stored in R1. |
| 12 | DIV | divide R1 by R2. the result is stored in R1. |
| 13 | JIP | jump if positive |
| 14 | JIN | jump if negative |
| 15 | STORE | store register value into memory |
| 16 | LOAD | load memory value into register |
| 17 | CMP | compare two registers (result stored in `R3`) |
| 18 | DEBUG | print register value (debug instruction) |
| 19 | PLOCATE | outputs the current pointer position (debug instruction) |

## limitations

* 4 registers
* 256 bytes of memory
* fixed-size instructions
* no labels
* no stack
* no CALL / RET
* no interrupts
* no memory protection

## roadmap

- [x] Virtual CPU
- [x] Assembler
- [x] Custom machine code format (`.ucpu`)
- [x] CLI
- [ ] Labels
- [ ] Stack
- [ ] CALL / RET
- [ ] Debugger
- [ ] Memory-mapped I/O
