-- load lcpp (ffi.cdef wrapper turned on per default)
local lcpp = require("lua.lcpp.lcpp")


-- or compile some code by hand
print("result:")
local result = lcpp.compile("...")
print(result)
print("out:")
local out = lcpp.compile([[
    #define MAXPATH 260
    typedef struct somestruct_t {
        void*          base;
        size_t         size;
        wchar_t        path[MAXPATH];
    } t_exe;
]])
print(out)
-- just use LuaJIT ffi and lcpp together
local wat = lcpp.compile([[
int printf(const char *fmt, ...);
#define __LUA 5.1
#include <dMM_E_debug.bt>
]])
print(wat)
love.filesystem.write("compiled.txt", wat)
ffi.cdef(wat)
ffi.C.printf("Hello %s!", "world")