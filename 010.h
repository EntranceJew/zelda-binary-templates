// dummy out all 010 functions
#define BitfieldDisablePadding void NOP
#define SetBackColor void NOP
#define SetForeColor void NOP

// define 010 colors
#define cDkBlue void *c
#define cLtBlue void *c

// dummy out our own defines / functions
#define SION  void NOP()
#define SIOFF void NOP()
#define SIT   void NOP()
#define SIBE  void NOP()
#define SIEND void NOP()

// make what isn't understood understood
#define local volatile

// dummy out types
#define uint64 uint64_t
#define uint32 uint32_t
#define uint uint32_t
#define ubyte wchar_t
#define byte wchar_t
#define hfloat float