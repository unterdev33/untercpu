local cpu = require("cpu")
local assembler = require("assembler")

local memory = assembler.assemble()

cpu.run(memory)