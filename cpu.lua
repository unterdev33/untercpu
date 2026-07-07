local cpu = {}

dump_registers = 0
dump_memory = 0

function cpu.dump_registers(registers)

    print("\nREGISTERS")

    for i = 0,3 do
        print("R"..i.." =", registers[i])
    end

end

function cpu.dump_memory(memory)

    print("\nMEMORY")

    for i = 0,255 do
        print("M"..i.." =", memory[i])
    end

end


function cpu.run(memory)

    local registers = {}

    for i = 0, 3 do
        registers[i] = 0
    end

    local pc = 0
    local running = true

    while running do

        if dump_mode == 1 then
            print("\n====================")
            print("PC =", pc)
        end

        local opcode = memory[pc]
        local arg1 = memory[pc + 1]
        local arg2 = memory[pc + 2]

        if opcode == 0 then
            print("\n\nCRITICAL ERROR!!!\nProgram terminated without HALT (reached empty memory at address " .. pc .. ")\n")
            os.exit()
        end

        if opcode == 1 then -- HALT
            running = false

        elseif opcode == 2 then -- MOV
            registers[arg1] = arg2
            pc = pc + 3

        elseif opcode == 3 then -- ADD
            registers[arg1] = registers[arg1] + registers[arg2]
            pc = pc + 3

        elseif opcode == 4 then -- SUB
            registers[arg1] = registers[arg1] - registers[arg2]
            pc = pc + 3

        elseif opcode == 5 then -- JMP
            pc = arg1

        elseif opcode == 6 then -- JNZ
            if registers[arg1] ~= 0 then
                pc = arg2
            else
                pc = pc + 3
            end

        elseif opcode == 7 then
            io.write(string.char(registers[arg1])) -- PRINT
            pc = pc + 3

        elseif opcode == 8 then
            registers[arg1] = registers[arg1] ~ registers[arg2] -- XOR (reg, reg, r0 = r0 xor r1)
            pc = pc + 3

        elseif opcode == 9 then
            registers[arg1] = registers[arg1] << arg2 -- SHL (reg, bit amount to shift)
            pc = pc + 3

        elseif opcode == 10 then
            registers[arg1] = registers[arg1] >> arg2 -- SHR (reg, bit amount to shift)

        elseif opcode == 11 then
            registers[arg1] = registers[arg1] * registers[arg2] -- MUL
            pc = pc + 3

        elseif opcode == 12 then
            registers[arg1] = registers[arg1] / registers[arg2] -- DIV
            pc = pc + 3

        elseif opcode == 13 then -- JIP
            if registers[arg1] > 0 then
                pc = arg2
            else
                pc = pc + 3
            end

        elseif opcode == 14 then --JIN
            if registers[arg1] < 0 then
                pc = arg2
            else
                pc = pc + 3
            end

        elseif opcode == 15 then -- STORE
            memory[arg2] = registers[arg1]
            pc = pc + 3

        elseif opcode == 16 then -- LOAD
            registers[arg1] = memory[arg2]
            pc = pc + 3

        elseif opcode == 17 then -- CMP
            if registers[arg1] > registers[arg2] then
                registers[4] = 1

            elseif registers[arg1] < registers[arg2] then
                registers[4] = -1

            else
                registers[4] = 0
            end

            pc = pc + 3

        elseif opcode == 18 then -- DEBUG
            io.write(registers[arg1])
            pc = pc + 3

        elseif opcode == 19 then -- PLOCATE
            io.write("\nPOINTER POSITION: ", pc, "\n")
            pc = pc + 3

        else
            print("\n\nCRITICAL ERROR!!!\nUnknown opcode " .. tostring(opcode) .. " at address " .. pc)
            os.exit()
        end
    if dump_registers == 1 then
        cpu.dump_registers(registers)
    end

    if dump_memory == 1 then
        cpu.dump_memory(memory)
    end

    end
    return registers
end

return cpu
