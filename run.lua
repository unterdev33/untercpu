local cpu = require("cpu")

local run = {}

function run.run(file)

    if not file:match("%.ucpu$") then
        file = file .. ".ucpu"
    end

    local path = "ucpu/" .. file

    local f = io.open(path, "r")

    if not f then
        error("Cannot open program: " .. path)
    end

    local memory = {}
    local i = 0

    for line in f:lines() do
        memory[i] = tonumber(line)
        i = i + 1
    end

    f:close()

    cpu.run(memory)

end

return run