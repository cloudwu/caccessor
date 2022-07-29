


--struct aaaa {
--};

local STRUCT = {}

local function parse_struct(code)
	local nest = {}
	local nest_n = 0
	code = code:gsub("(%b{})" , function(v)
		nest_n = nest_n + 1
		nest[nest_n] = v
		return "{" .. nest_n .. "} "
	end)
	local names = {}
	local lines = {}
	local line_n = 0
	for line in code:gmatch "%s*(.-)%s*;" do
		line_n = line_n + 1
		-- strip spaces
		line = line:gsub("%s+", " ")
		line = line:gsub(" ?%*%s*", " *")
		local prefix , array = line:match "^(.-)%s*(%b[])$"
		if array then
			array = math.tointeger(array:match "%[(%d+)%]") or 0
			line = prefix
		end
		local typestr, pointer, name = line:match "^(.-) (%**)([_%w]+)$"
		assert(typestr, line)
--		local type_prefix = typestr:match "^([%w_]+)"
--		if type_prefix == "struct" then
--		else
--		end
		local t = {
			array = array,
			type = typestr,
			pointer = pointer~="" and pointer,
			name = name,
		}
		assert(names[name] == nil, name)
		names[name] = true
		lines[line_n] = t
		print("LINE", line_n, t.name, t.type, t.array, t.pointer)
	end

end

local function structs(code)
	local s = {}
	for typename, content in code:gmatch "struct%s+([_%w]+)%s*(%b{})%s*;" do
		assert(s[typename] == nil)
		s[typename] = parse_struct(content:match "^{%s*(.-)%s*}$")
	end
end


structs [[
	struct aaa {
		struct {
			int a;
			int b;
		} v;
		int *a [];
		int b;
	};
]]

