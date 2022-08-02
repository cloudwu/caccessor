local test = require "caccessor.test"
local caccessor = require "caccessor"

local code = [[

struct node {
	float x;
	float y;
};

struct list {
	struct node node[2];
	struct list * next;
};

]]

local s = caccessor.datastruct(code)

local sz = s:size "struct list"

local get_x = s:getter "struct list.node[0].x"
local get_y = s:getter "struct list.node[0].y"
local set_x = s:setter "struct list.node[0].x"
local set_y = s:setter "struct list.node[0].y"
local get_next = s:getter "struct list.next"
local set_next = s:setter "struct list.next"

local head = test.udata(sz)

set_x(head , 0)
set_y(head , 0)
set_next(head, test.NULL)

local last = head

for i = 1, 10 do
	local obj = test.udata(sz)
	set_next(last, obj)
	set_x(obj, i)
	set_y(obj, -i)
	set_next(obj, test.NULL)
	last = obj
end

print(s:getter("struct list.next.next.next.node.x")(head))
print(s:getter("struct list.next.next.next.node.y")(head))

--s:dump()
