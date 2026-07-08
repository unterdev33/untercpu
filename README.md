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

## instruction set and memory

**ISA and memory available on google sheets:** https://docs.google.com/spreadsheets/d1mtu_ajOosjGi8C20cFWCVu4Y1kvMKEs9cEdgPnMOWeI/

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
