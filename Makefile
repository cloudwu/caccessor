LUA_INC=-I /e/opensource/lua/src
LUA_LIB=-L /usr/local/bin -llua54

CFLAGS=-O2 -Wall
SHARED=--shared -fPIC

all : caccessor.dll

caccessor.dll : caccessor.c
	gcc $(CFLAGS) $(SHARED) -o $@ $^ $(LUA_INC) $(LUA_LIB)

clean :
	rm -f caccessor.dll
