

local AppSettings = {
	["LastPatch"] = 1743035151,
	["AppMode"] = "early alpha",
	["Author"] = "boydev1444",
	["GlobalVersion"] = 1,
	["MaxOptimizedBytecodeLen"] = 1954,
	["ObligatoryLuauVersion"] = 6,
	["SupportedModes"] = {
		"advanced",
		"disassemble"
	},
	["NoteTypes"] = {
		["e"] = "error",
		["w"] = "warning",
		["p"] = "note"
	},
	["DefaultTypesVersion"] = 3,
	["MissingProtoName"] = "(MISSING)",
	["MainProtoName"] = "(MAIN)",
}

local DefaultOptions = {
	["OptimizeBytecode"] = true,
	["ShowDebugInfo"] = true,
	["DecompilerMode"] = "advanced"
}

local ARG_RENAME = "arg%d"
local VariableRename = "R%d"
local UpvalueRename = "%*_upvr_%d"

local Luau = {
	["OPList"] = {
		{ "NOP", 0, 0, false },
		{ "BREAK", 0, 0, false },
		{ "LOADNIL", 1, 0, false },
		{ "LOADB", 3, 0, false },
		{ "LOADN", 4, 0, false },
		{ "LOADK", 4, 3, false },
		{ "MOVE", 2, 0, false },
		{ "GETGLOBAL", 1, 1, true },
		{ "SETGLOBAL", 1, 1, true },
		{ "GETUPVAL", 2, 0, false },
		{ "SETUPVAL", 2, 0, false },
		{ "CLOSEUPVALS", 1, 0, false },
		{ "GETIMPORT", 4, 4, true },
		{ "GETTABLE", 3, 0, false },
		{ "SETTABLE", 3, 0, false },
		{ "GETTABLEKS", 3, 1, true },
		{ "SETTABLEKS", 3, 1, true },
		{ "GETTABLEN", 3, 0, false },
		{ "SETTABLEN", 3, 0, false },
		{ "NEWCLOSURE", 4, 0, false },
		{ "NAMECALL", 3, 1, true },
		{ "CALL", 3, 0, false },
		{ "RETURN", 2, 0, false },
		{ "JUMP", 4, 0, false },
		{ "JUMPBACK", 4, 0, false },
		{ "JUMPIF", 4, 0, false },
		{ "JUMPIFNOT", 4, 0, false },
		{ "JUMPIFEQ", 4, 0, true },
		{ "JUMPIFLE", 4, 0, true },
		{ "JUMPIFLT", 4, 0, true },
		{ "JUMPIFNOTEQ", 4, 0, true },
		{ "JUMPIFNOTLE", 4, 0, true },
		{ "JUMPIFNOTLT", 4, 0, true },
		{ "ADD", 3, 0, false },
		{ "SUB", 3, 0, false },
		{ "MUL", 3, 0, false },
		{ "DIV", 3, 0, false },
		{ "MOD", 3, 0, false },
		{ "POW", 3, 0, false },
		{ "ADDK", 3, 2, false },
		{ "SUBK", 3, 2, false },
		{ "MULK", 3, 2, false },
		{ "DIVK", 3, 2, false },
		{ "MODK", 3, 2, false },
		{ "POWK", 3, 2, false },
		{ "AND", 3, 0, false },
		{ "OR", 3, 0, false },
		{ "ANDK", 3, 2, false },
		{ "ORK", 3, 2, false },
		{ "CONCAT", 3, 0, false },
		{ "NOT", 2, 0, false },
		{ "MINUS", 2, 0, false },
		{ "LENGTH", 2, 0, false },
		{ "NEWTABLE", 2, 0, true },
		{ "DUPTABLE", 4, 3, false },
		{ "SETLIST", 3, 0, true },
		{ "FORNPREP", 4, 0, false },
		{ "FORNLOOP", 4, 0, false },
		{ "FORGLOOP", 4, 8, true },
		{ "FORGPREP_INEXT", 4, 0, false },
		{ "FASTCALL3", 3, 1, true },
		{ "FORGPREP_NEXT", 4, 0, false },
		{ "DEP_FORGLOOP_NEXT", 0, 0, false },
		{ "GETVARARGS", 2, 0, false },
		{ "DUPCLOSURE", 4, 3, false },
		{ "PREPVARARGS", 1, 0, false },
		{ "LOADKX", 1, 1, true },
		{ "JUMPX", 5, 0, false },
		{ "FASTCALL", 3, 0, false },
		{ "COVERAGE", 5, 0, false },
		{ "CAPTURE", 2, 0, false },
		{ "SUBRK", 3, 7, false },
		{ "DIVRK", 3, 7, false },
		{ "FASTCALL1", 3, 0, false },
		{ "FASTCALL2", 3, 0, true },
		{ "FASTCALL2K", 3, 1, true },
		{ "FORGPREP", 4, 0, false },
		{ "JUMPXEQKNIL", 4, 5, true },
		{ "JUMPXEQKB", 4, 5, true },
		{ "JUMPXEQKN", 4, 6, true },
		{ "JUMPXEQKS", 4, 6, true },
		{ "IDIV", 3, 0, false },
		{ "IDIVK", 3, 2, false },
	},
	["BytecodeTag"] = {
		CONSTANT_NIL = 0,
		CONSTANT_BOOLEAN = 1,
		CONSTANT_NUMBER = 2,
		CONSTANT_STRING = 3,
		CONSTANT_IMPORT = 4,
		CONSTANT_TABLE = 5,
		CONSTANT_CLOSURE = 6,
		CONSTANT_VECTOR = 7
	}
}

local getscriptbytecode = getscriptbytecode
local pycompile = pycompile

local luau_compile = getscriptbytecode or pycompile or function(Instance)
	local code = (type(Instance) == "string" and Instance or Instance.Source)
	return require(game.ReplicatedStorage.Ception).luau_compile(code)
end

local function SanitizeItem(obj)
	return obj or "NOT_FOUNDED_BY_MOONDEC"
end

local function table_reverse(t)
	local t2 = table.move(t, 1, #t, 1, {}); for i = 1, #t2 // 2 do t2[i], t2[#t2 - i + 1] = t2[#t2 - i + 1], t2[i] end
	return t2
end

local LuauBytecodeTag = Luau.BytecodeTag

local string_format = string.format
local string_len = string.len
local string_sub = string.sub
local string_gmatch = string.gmatch
local string_gsub = string.gsub

local os_time = os.time
local os_clock = os.clock
local os_date = os.date

local math_floor = math.floor
local math_abs = math.abs

local table_create = table.create
local table_insert = table.insert
local table_concat = table.concat
local table_remove = table.remove
local table_sort = table.sort

local to_bytes = tobytes or function(input)
	local str = {}
	for i = 1 , string_len(input) do
		table_insert(str , string_sub(input , i , i):byte())
	end
	return table_concat(str , "\\")
end

local addc = function(n) return tostring(n):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") end
local env = (getgenv or getrenv or getfenv)

local moon = {}
local table_find = function(table , value)
	local founded = nil
	for i , v in pairs(table) do
		if v == value then
			founded = i
			break
		end
	end
	return founded
end

local function FormatTimestamp(timestamp)
	local date = os_date("*t", timestamp)
	local months = { "January", "February", "March", "April", "May", "June", 
		"July", "August", "September", "October", "November", "December" }
	local hour = date.hour % 12
	hour = hour == 0 and 12 or hour
	local ampm = date.hour >= 12 and "p.m." or "a.m."
	return string_format("%d of %s %d, %d:%02d %s", 
		date.day, months[date.month], date.year, hour, date.min, ampm)
end

local request = request
local pyrequest = pyrequest

local function getsafeObj(i,v)
	local ok = pcall(function()
		return i[v]
	end)
	return ok
end

local function HTTPRequest(url, method, optional)
	optional = optional or {}

	-- When called from discord
	if pyrequest then -- This is in the "setup.py" file (discord bot handling)
		local response = pyrequest({
			["Url"] = url,
			["Method"] = method,
			["Extra"] = optional or {}
		})
		if response.code ~= 200 then
			error( string_format("Failed to call \"%*\" with python_http ( HTTP %d )" , url , response.code))
			return ""
		end
		return response.text
	end

	-- Exploit request (type 1)
	if request then 
		local response = request({
			["Url"] = url,
			["Method"] = method,
			["Body"] = optional.body,
			["Headers"] = optional.headers
		})
		if response.StatusCode ~= 200 then
			error( string_format("Failed to call \"%*\" ( HTTP %d )" , url , response.StatusCode))
		end
		return response.Body
	end
	-- Try game:HttpGet (only for GET requests)
	if getsafeObj(game , "HttpGet") then
		if method == "GET" then
			local success, body = pcall(function()
				return game:HttpGet(url)
			end)
			if success then return body end
			return string_format("-- Failed to send a request with game:HttpGet to \"%*\"", url)
		end
	end

	-- Use HttpService
	local Methods = {
		["POST"] = "PostAsync",
		["GET"] = "GetAsync",
	}
	local Http = game:GetService("HttpService")
	if not Methods[method] then
		return string_format("Invalid method \"%*\"" , method)
	end
	local success, body = pcall(function()
		if method == "POST" then
			return Http:PostAsync(url, Http:JSONEncode(optional.body) or "", Enum.HttpContentType.ApplicationJson, false , optional.headers or nil)
		else
			return Http:GetAsync(url, false, optional.headers or nil)
		end
	end)
	if not success then
		return string_format("-- Failed requesting url with HttpService to \"%*\"", url)
	end
	return body
end

local function GetFromWeb(fileName , customType)
	local BASE_URL = "https://raw.githubusercontent.com/"
	local AUTHOR = "boydev-1444"
	local REPO = "RunLuauDecompiler"
	local BRANCH = "refs/heads/main"
	if customType == "u" then
		customType = "luau"
	end
	local FILE_TYPE = customType or "lua"
	local URL = table_concat({ BASE_URL , AUTHOR , REPO , BRANCH } , "/") .. "/" .. fileName .. "." .. FILE_TYPE
	local Request = HTTPRequest(URL , "GET")
	if customType == "json" then
		return Request
	end
	local METHOD = loadstring or load
	Request = METHOD(Request)
	if type(Request) ~= "function" then
		return "Request failed"
	end
	return Request()
end

local Reader = GetFromWeb("reader")

--@field MoonDecompiler (decompile) main method, made by boydev1444
function moon.decompile(Input , CustomOptions)
	local CurrentOptions = CustomOptions or DefaultOptions
	local File = (type(Input) == "table" and (Input.filename ~= nil and Input.content ~= nil) or false) --// Is file
	local SourceInput = (File and Input.content or Input)
	local Version = tostring(_VERSION) -- Should be Lua/u
	local success , bytecode = pcall(function()
		if typeof(Input) == "string" then
			return Input
		end
		return luau_compile(SourceInput)
	end)
	local mode = CurrentOptions.DecompilerMode or DefaultOptions.DecompilerMode
	local function __moon()
		local source = {}
		local elapsed_t = os_clock()
		local LuauVersion , TypesVersion
		local stream = Reader(bytecode)
		local NIL_CONSTANTS = 0
		LuauVersion = stream:readByte()
		TypesVersion = stream:readByte()
		local function __decompile()
			local string_count = stream:nextVarInt()
			stringList = table_create(string_count)
			for i = 1 , string_count do
				stringList[i] = stream:readString()
			end
			if TypesVersion == 3 then
				local index = stream:readByte()
				while index ~= 0 do
					stream:nextVarInt()
					index = stream:readByte()
				end
			end
			local GLOBAL_CONSTANTS = {}
			local protoCount = stream:nextVarInt()
			local encoded_instructions = {}
			local protoList = table_create(protoCount)
			local function __dec_instruction(index , writedInstructions)
				local value = stream:readWord()
				local opcode = bit32.band(value, 0xFF)
				table_insert(encoded_instructions , opcode)
				local opInfo = Luau.OPList[opcode + 1]
				if not opInfo then
					if CurrentOptions.ShowDebugInfo then
					end
					return false
				end
				local opname = opInfo[1]
				local opmode = opInfo[2]
				local kmode = opInfo[3]
				local usesAux = opInfo[4]
				local instruction = {
					opcode = opcode;
					opname = opname;
					opmode = opmode;
					kmode = kmode;
					usesAux = usesAux;
				}
				if opmode == 1 then --[[ A ]]
					instruction.A = bit32.band(bit32.rshift(value, 8), 0xFF)
				elseif opmode == 2 then --[[ AB ]]
					instruction.A = bit32.band(bit32.rshift(value, 8), 0xFF)
					instruction.B = bit32.band(bit32.rshift(value, 16), 0xFF)
				elseif opmode == 3 then --[[ ABC ]]
					instruction.A = bit32.band(bit32.rshift(value, 8), 0xFF)
					instruction.B = bit32.band(bit32.rshift(value, 16), 0xFF)
					instruction.C = bit32.band(bit32.rshift(value, 24), 0xFF)
				elseif opmode == 4 then --[[ AD ]]
					instruction.A = bit32.band(bit32.rshift(value, 8), 0xFF)
					local temp = bit32.band(bit32.rshift(value, 16), 0xFFFF)
					instruction.D = if temp < 0x8000 then temp else temp - 0x10000
				elseif opmode == 5 then --[[ AE ]]
					local temp = bit32.band(bit32.rshift(value, 8), 0xFFFFFF)
					instruction.E = if temp < 0x800000 then temp else temp - 0x1000000
				end
				if usesAux then 
					local aux = stream:readWord()
					instruction.aux = aux
				end
				table_insert(writedInstructions , instruction)
				return usesAux
			end
			for i = 1 , protoCount do
				local proto = {
					["protoId"] = i - 1,
					["constants"] = {},
					["instructions"] = {},
					["lineInfoInstructions"] = {},
					["constantsLength"] = 0,
					["maxstacksize"] = stream:readByte(),
					["numparams"] = stream:readByte(),
					["nups"] = stream:readByte(),
					["varArg"] = stream:readByte() ~= 0,
				}
				if LuauVersion >= 4 then -- Proto Flags!!
					proto.flags = stream:readByte()
					local resultTypedParams = {}
					local resultTypedUpvalues = {}
					local resultTypedLocals = {}
					local allTypeInfoSize = stream:nextVarInt()
					local hasTypeInfo = allTypeInfoSize > 0
					proto.hasTypeInfo = hasTypeInfo
					if hasTypeInfo then
						local totalTypedParams = allTypeInfoSize
						local totalTypedUpvalues = 0
						local totalTypedLocals = 0
						if TypesVersion > 1 then
							totalTypedParams = stream:nextVarInt()
							totalTypedUpvalues = stream:nextVarInt()
							totalTypedLocals = stream:nextVarInt()
						end
						local function readTypedParams()
							local typedParams = resultTypedParams
							if totalTypedParams > 0 then
								local function nextbytes(c)
									local bytes = {}
									for i = 1 , c do
										table_insert(bytes, stream:readByte())
									end
									return bytes
								end
								typedParams = nextbytes(totalTypedParams)
								table_remove(typedParams, 1)
								table_remove(typedParams, 1)
							end
							return typedParams
						end
						local function readTypedUpvalues()
							local typedUpvalues = resultTypedUpvalues
							if proto.nups > 0 then
								for i = 1, totalTypedUpvalues do
									local upvalueType = stream:readByte()
									local info = {
										type = upvalueType
									}
									typedUpvalues[i] = info
								end
							end
							return typedUpvalues
						end
						local function readTypedLocals()
							local typedLocals = resultTypedLocals
							if totalTypedLocals > 0 then
								for i = 1, totalTypedLocals do
									local localType = stream:readByte()
									local localRegister = stream:readByte()
									local localStartPC = stream:nextVarInt() + 1
									local localEndPC = stream:nextVarInt() + localStartPC - 1
									local info = {
										type = localType,
										register = localRegister,
										startPC = localStartPC,
										endPC = localEndPC
									}
									typedLocals[i] = info
								end
							end
							return typedLocals
						end
						resultTypedParams = readTypedParams()
						resultTypedUpvalues = readTypedUpvalues()
						resultTypedLocals = readTypedLocals()
					end
					proto.typedParams = resultTypedParams
					proto.typedUpvalues = resultTypedUpvalues
					proto.typedLocals = resultTypedLocals
				end
				proto.instructionsLength = stream:nextVarInt()
				proto.writedInstructions = table_create(proto.instructionsLength)
				local skip_next = false
				for i = 1, proto.instructionsLength do
					if skip_next then
						skip_next = false
						continue
					end
					skip_next = __dec_instruction(i , proto.writedInstructions)
				end
				proto.constantsLength = stream:nextVarInt()
				for i = 1 , proto.constantsLength do
					local constantType = stream:readByte()
					local constant
					if constantType == LuauBytecodeTag.CONSTANT_NIL then
						NIL_CONSTANTS += 1
						constant = "nil"
						continue
					elseif constantType == LuauBytecodeTag.CONSTANT_BOOLEAN then
						constant = stream:readByte() ~= 0
					elseif constantType == LuauBytecodeTag.CONSTANT_NUMBER then
						constant = stream:nextDouble()	
					elseif constantType == LuauBytecodeTag.CONSTANT_STRING then
						local stringId = stream:nextVarInt()
						local string = stringList[stringId]
						constant = string
					elseif constantType == LuauBytecodeTag.CONSTANT_IMPORT then
						constant = stream:readWord()
					elseif constantType == LuauBytecodeTag.CONSTANT_TABLE then
						local dataLength = stream:nextVarInt()
						constant = table_create(dataLength)
						for i = 1, dataLength do
							constant[i] = stream:nextVarInt()
						end
					elseif constantType == LuauBytecodeTag.CONSTANT_CLOSURE then
						constant = stream:nextVarInt()
					elseif constantType == LuauBytecodeTag.CONSTANT_VECTOR then
						local x , y , z , w
						x = stream:nextFloat()
						y = stream:nextFloat()
						z = stream:nextFloat()
						w = stream:nextFloat()
						constant = string_format("V|%*|" , table_concat({x,y,z,w}))
					end
					if env()[constant] then
						table_insert(GLOBAL_CONSTANTS, constant)
					end
					table_insert(proto.constants , constant)
				end
				local sizep = stream:nextVarInt()
				local protolist = table_create(sizep)
				for i = 1, sizep do
					protolist[i] = stream:nextVarInt() + 1
				end
				local linedefined = stream:nextVarInt()
				local debugnameindex = stream:nextVarInt()
				local debugname 
				if debugnameindex ~= 0 then
					debugname = stringList[debugnameindex]
				else 
					debugname = AppSettings.MissingProtoName
				end
				proto.innerProtos = protolist
				proto.name = debugname
				proto.linedefined = linedefined
				local lineinfoenabled = stream:readByte() ~= 0
				local instructionlineinfo 
				if lineinfoenabled then
					local linegaplog2 = stream:readByte()
					local sizecode = proto.instructionsLength
					local intervals = bit32.rshift((sizecode - 1), linegaplog2) + 1
					local lineinfo = table_create(sizecode)
					local lastoffset = 0
					for j = 1, sizecode do
						lastoffset = lastoffset + stream:readByte()
						lineinfo[j] = lastoffset
					end
					local abslineinfo = table_create(intervals)
					local lastline = 0
					for j = 1, intervals do
						lastline = lastline + stream:readWord()
						abslineinfo[j] = lastline % (2^32)
					end
					instructionlineinfo = table_create(sizecode)
					for pc = 1, sizecode do
						local intervalIndex = bit32.rshift(pc - 1, linegaplog2) + 1
						local baseLine = abslineinfo[intervalIndex]
						local offset = lineinfo[pc]
						if baseLine and offset then
							instructionlineinfo[pc] = baseLine + offset
						else
							instructionlineinfo[pc] = proto.linedefined or 0
						end
					end
				end
				if instructionlineinfo then
					proto.instructionlineinfo = instructionlineinfo
				end
				local hasDebugInfo = stream:readByte() ~= 0
				proto.hasDebugInfo = hasDebugInfo
				if hasDebugInfo then
					local totalDebugLocals = stream:nextVarInt()
					local function readDebugLocals()
						local debugLocals = {}
						for i = 1, totalDebugLocals do
							local localName = stringList[stream:nextVarInt()]
							local localStartPC = stream:nextVarInt()
							local localEndPC = stream:nextVarInt()
							local localRegister = stream:readByte()
							local info = {
								name = localName,
								startPC = localStartPC,
								endPC = localEndPC,
								register = localRegister
							}
							debugLocals[i] = info
						end
						return debugLocals
					end
					proto.debugLocals = readDebugLocals()
					local totalDebugUpvalues = stream:nextVarInt()
					local function readDebugUpvalues()
						local debugUpvalues = {}
						for i = 1, totalDebugUpvalues do
							local upvalueName = stringList[stream:nextVarInt()]
							local info = {
								name = upvalueName
							}
							debugUpvalues[i] = info
						end
						return debugUpvalues
					end
					proto.debugUpvalues = readDebugUpvalues()
				end
				table_insert(protoList , proto)
			end
			local mainProtoId = stream:nextVarInt() + 1
			local mainproto = protoList[mainProtoId]
			local function _ldecompile()
				local main = {}
				local referenced_indexes = {
					[2] = "l__RunService__1" 
				}
				local refenced_functions = {
					[1] = "SomeFunction"
				}
				local function decomp(proto)
					local str = {}
					local linesMap = {}
					for pc, instruction in ipairs(proto.writedInstructions) do
						local line = proto.instructionlineinfo[pc]
						if line then
							linesMap[line] = linesMap[line] or {}
							table.insert(linesMap[line], {pc , instruction})
						end
					end
					local function formatRegister(register)
						local parameterRegister = register + 1
						if parameterRegister < proto.numparams + 1 then
							return ARG_RENAME:format(((proto.numparams - proto.numparams) + parameterRegister))
						end
						return VariableRename:format((register - proto.numparams))
					end
					local function FormatVariable(register)
						return "local " .. formatRegister(register) .. " = "
					end
					local function generate_ast(instruction)
						local constants = proto.constants
						local AST = {
							["type"] = "Variable",
							["identifier"] = VariableRename:format(instruction.A),
							["declarations"] = {}
						}
						local opname = instruction.opname
						local A = instruction.A
						local B = instruction.B
						if opname == "CALL" then
							local func = refenced_functions[A] or formatRegister(A)
							for i = 1 , (B - 1) do
								print(i)
							end
						end
						return AST
					end
					for _ , data in linesMap do
						local line_internal = {}
						local line = {}
						for position , raw in data do
							local block , instruction = raw[1] , raw[2]						
							if instruction then
								generate_ast(instruction)
							end
						end
						table_insert(str , table_concat(line , "\n"))
					end
					return table_concat(str , "\n")
				end
				print(mainproto)
				table_insert(main , decomp(mainproto))
				return table_concat(main , "\n")
			end
			table_insert(source , _ldecompile())
		end
		local function _asserts()
			assert(success == true , "Failed to grab bytecode! (" .. tostring(bytecode) .. ")")
			assert(type(bytecode) == "string" , string_format("Invalid bytecode input (string expected , got %*)", type(bytecode)))
			assert(Version == "Luau" or Version == "Lua", string_format("Unvalid Lang version (Lua/u expected got %*)" , Version))
			assert(LuauVersion == AppSettings.ObligatoryLuauVersion , string_format("Luau Version %d is not supported, try inserting a Luau source, or check your script syntax" , LuauVersion))
		end
		_asserts()
		__decompile()
		assert((stream:__getc() <= stream:__getlen()), `Buffer access out of bounds ({stream:__getc()} > {stream:__getlen()})`)
		return table_concat(source , "\n") , {
			["ElapsedTime"] = os_clock() - elapsed_t,
			["TypesVersion"] = TypesVersion,
			["LuauVersion"] = LuauVersion,
		}
	end
	local output , extra = __moon()
	extra = extra or {}
	local Bytecode = (function()
		local bytes = to_bytes(bytecode)
		local bytes_len = string_len(bytes)
		if CurrentOptions.OptimizeBytecode then
			if bytes_len >= AppSettings.MaxOptimizedBytecodeLen then
				return string_format("Bytecode input is higher than %* characters (%* actual characters), removed bytecode for optimization by the decompiling settings" , addc(AppSettings.MaxOptimizedBytecodeLen) , addc(bytes_len))
			end
		end
		return bytes
	end)()

	local Output = {
		string_format("-- Decompiled With Moon, %* Decompiler made by %* (%* and version %d)", Version , AppSettings.Author , AppSettings.AppMode , AppSettings.GlobalVersion),
		string_format("-- Last Patch on %*" , FormatTimestamp(AppSettings.LastPatch)),
		string_format("-- Bytecode: %*", Bytecode),
		string_format("-- Luau Version %d , Types Version %d", extra.LuauVersion , extra.TypesVersion),
		string_format("-- Time taken: %* second(s)", string_format("%.10f" , extra.ElapsedTime or 0)),
		string_format("-- Decompiled on %*", FormatTimestamp(os_time())),
		string_format("-- Decompiled using the \"%*\" mode" , mode)
	}
	if File then
		local function getFileSize()
			local bytes = string_len(Input.content)
			local types = {"Byte(s)", "KB", "MB", "GB", "TB", "Nah bruh you're sick"}
			local index = 1
			while bytes >= 1024 and index < #types do
				bytes = bytes / 1024
				index = index + 1
			end
			local sizeType = types[index]
			if math_floor(bytes) == bytes then -- Is not decimal
				return string_format("%d %s", math_floor(bytes), sizeType)
			else
				return string_format("%.2f %*" , bytes , sizeType)
			end
		end
		table_insert(Output , string_format("-- Source File: \"%*\" (%*)", Input.filename , getFileSize()))
	else
		-- Verifies if is a script Instance
		local type = type(Input)
		if type == "userdata" then
			if getsafeObj(Input , "IsA") then
				if getsafeObj(Input , "ClassName") then
					if Input:IsA'Instance' then
						local function getPath()
							local path = {}
							local p = Input
							repeat
								table_insert(path, "\"" .. p.Name .. "\"")
								p = p.Parent
							until p == game
							path = table_reverse(path)
							path = table_concat(path , " , ")
							return "[" .. tostring(path) .. "]"
						end
						table_insert(Output , string_format("-- %*'s path: %*" , Input.Name , getPath()))
					end
				end
			end
		end
	end
	local r =  Random.new():NextNumber(0.3 , 0.6)
	if r < 0.39 then
		local function SomeCoolMessage()
			local message = "No cool message provided, sad."
			local t = {
				"Boo! 👻",
				"Cool thing",
				"I'm gonna improve this comming soon",
				"Luau not available!!"
			}
			message = t[Random.new():NextInteger(1,#t)]
			return message
		end
		table_insert(Output , "-- " .. SomeCoolMessage())
	end
	table_insert(Output , "")
	local function TopNote(messag , customtype)
		local type = customtype or "p"
		table_insert(Output, string_format("-- [MOONDEC%*]: %*", (AppSettings.NoteTypes[type] or AppSettings.NoteTypes.p):upper() , tostring(messag)))
	end
	if CurrentOptions.ShowDebugInfo then
		TopNote("[ShowDebugInfo] Enabled, detailed process notes are enabled")
	end
	if extra then
		if extra.TypesVersion then
			if extra.TypesVersion ~= AppSettings.DefaultTypesVersion then
				TopNote(string_format("Unusually Types Version, normally is %d, but in this case is %d" , AppSettings.DefaultTypesVersion , extra.TypesVersion) , "w")
			end
		end
	end
	if type(output) == "table" then
		table_insert(Output , output[1])
	else
		table_insert(Output , output)
	end
	return table_concat(Output , "\n")
end

setmetatable(moon, {
	__call = function(self, name, ...)
		if self[name] then
			local args = {...}
			local _ , result = xpcall(function()
				return tostring(self[name](unpack(args)))
			end, function(error)
				local traceback = debug.traceback(error,5)
				local lines = {}
				local i = 1
				local _ , reason = string.match(error , ":(%d+):?%s*(.-)$")
				if not reason then
					reason = error
				end
				for line in string_gmatch(traceback , ":(%d+):?%s?") do
					local funcname = debug.info(i , "n")
					table_insert(lines , string_format("moon:%d:%*", tonumber(line) , (function()
						if funcname and funcname ~= "" then
							return string_format(" at function \"%*\"", funcname)
						else
							if i == 1 then
								return " " .. reason
							end
						end
						return ""
					end)()))
					i = i + 1
				end
				return string_format("--[[ Moon Error Ocurred! (\"%*\") at line(s):\n%*\n]]", name , table_concat(lines , "\n"))
			end)
			return result
		end
	end,
})

env().custom_decompile = function(script)
	return moon("decompile" , script , {
		["DecompilerMode"] = "advanced",
		["OptimizeBytecode"] = true,
		["ShowDebugInfo"] = true,
		["ListGlobals"] = true
	})
end
warn("Initialized Moon Decompiler.")
return moon
