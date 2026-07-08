local build = {}
local warned = false

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
    DEBUG = 18,
    PLOCATE = 19,
    MOD = 20,
    PUSH = 21,
    POP = 22,
    CALL = 23,
    RET = 24
}

local function get_source_lines(path)
    local lines = {}
    local file = io.open(path, "r")

    if not file then
        error("Cannot open file: " .. path)
    end

    for line in file:lines() do
        if line:match("%S") then
            table.insert(lines, line)
        end
    end

    file:close()
    return lines
end

function build.run(input)

    local lines = get_source_lines(input)

    local memory = {}

    for i = 0,255 do
        memory[i] = 0
    end

    local address = 0

    for line_number, line in ipairs(lines) do

        local cmd = {}

        for token in line:gmatch("%S+") do

            if (token == "PLOCATE" or token == "DEBUG") and not warned then
                print("WARNING!\nThis code uses debugging instructions. They are not part of the processor architecture and should not be used in release programs.")
                warned = true
            end

            local value = opcode[token]

            if not value then
                value = tonumber(token:match("R(%d+)") or token)
            end

            if value == nil then
                error(string.format(
                    "Assembly error at line %d: Unknown token '%s'",
                    line_number,
                    token
                ))
            end

            table.insert(cmd, value)

        end

        while #cmd < 3 do
            table.insert(cmd, 0)
        end

        for _, value in ipairs(cmd) do
            memory[address] = value
            address = address + 1
        end

    end

    local filename = input:match("([^/]+)%.uasm$")
    local output = "ucpu/" .. filename .. ".ucpu"

    local file = io.open(output, "w")

    if not file then
        error("Cannot create file: " .. output)
    end

    for i = 0,255 do
        file:write(memory[i], "\n")
    end

    file:close()

    print("Built " .. output)

end

return build