--enterpoint = "./main.uasm"

local opcode = {
    HALT = 1,
    MOV = 2,
    ADD = 3,
    SUB = 4,
    JMP = 5,
    JNZ = 6,
    PRINT = 7,
    XOR = 8,
    SHL = 9,
    SHR = 10,
    MUL = 11,
    DIV = 12,
    JIP = 13,
    JIN = 14,
    STORE = 15,
    LOAD = 16,
    CMP = 17,
    DEBUG = 18
}

local assembler = {}

local function get_source_lines(path)
    local lines = {}
    local file = io.open(path, "r")
    if not file then return nil end

    for line in file:lines() do
        if line:match("%S+") then
            table.insert(lines, line)
        end
    end
    file:close()
    return lines
end

function assembler.assemble()

    local lines = get_source_lines(path)
    local memory = {}
    local address = 0

    for i = 0, 255 do
        memory[i] = 0
    end

    if lines then
        for _, line in ipairs(lines) do
            local cmd = {}

            for token in line:gmatch("%S+") do
                local value = opcode[token]

                if token == "DEBUG" then
                    print("\nWARNING!\n\nDEBUG is a debugging instruction. It is not part of the actual processor architecture and is intended solely for program development and testing. In final programs, it is recommended to use PRINT to output characters, rather than DEBUG.\n")
                end

                if not value then
                    value = tonumber(token:match("R(%d+)") or token)
                end

                if value == nil then
                    print("\n\nAssembly error:\nUnknown token '" .. token .. "'")
                    os.exit()
                end

                table.insert(cmd, value)
            end

            while #cmd < 3 do
                table.insert(cmd, 0)
            end

            for _, val in ipairs(cmd) do
                memory[address] = val
                address = address + 1
            end
        end
    end
    return memory
end

return assembler