#MAJOR BUGS:
- Every time I open the tools window and save it crashes. :(

#THINGS I WANT FROM 010 EDITOR:
## Warnings
- Errors are reported post-define expansion, this can throw one off.
- Sometimes warnings don't generate newlines correctly. Any errors, assertions, or warnings 
	![hiding my error message](http://i.imgur.com/L62erGQ.png)
	You can always work around these by fighting convention with:
	
	```C
	void NLAssert(uint64 cond, string msg){
		if( !cond ){
			Printf("\n");
		}
		Assert(cond, msg);
	}
	```
	
	And always placing newline prints at the beginning, but this does not work for text
	printed via `Assert()` because it disregards newlines:
	![somewhere in that text is the data I need](http://i.imgur.com/hocjhNa.png)
	I don't see too much of a point to this because a failed assert is the last thing
	anyone will see.
	
- Wrapping `Assert()` makes it difficult to actually jump to the beginning of the
	offending code. This is in contrast of copying and pasting the same bit of code
	everywhere. 
## PreProcessor
- Access to preprocessor macros like expanding the following to strings:
	- __LINE__
	- __FILE__
	- __DIR__
	- __FUNCTION__
	- __LASTVAR__
	- __LASTVARNAME__
	- __LASTVARTYPE__
	- __STRUCT__
	Would reduce the number of use cases for wrapping prints heavily.
## Bookmarks
- Bookmarks for structs with arguments fail because they are missing arguments,
	this could be mitigated by providing a type-suggested UI based on a function
	signature and AddBookmark being a VarArg()
- (could be scripted) A keyboard shortcut to define a bookmark inside a bookmark inside the existing one,
	splitting it in half and resuming where the last one left off would be good.
	Sometimes I bookmark a uchar range that contains lots of data to easily create
	and lock my selection when searching, but once I find significant data inside this
	I cannot make note of it within the application and have to use an external tool.
- AddBookmark doesn't process template instructions like Printf's in the output panel.
	This usually isn't too bad, because if a file were to be processed 

## Inspector
- If I have a custom inspector file and it is using a type defined elsewhere, and that
	type implements its own sub-type, when reading the data it generates alerts that
	it has exceeded the end of the file. This is minor, but distracting. For larger types,
	or structures this could be hard to work around, to do a safe read before declaring itself.
	It also seems easily avoidable because it attempts to call the read function even if the
	size would show that it doesn't have enough room.
	It seems to only happen to structures / typedefs that utilize a read function.
- Occasionally, when trying to follow suit of the default Inspector / reloading it, it
	complains that the variable pos has already been defined. I don't think there is
	anything I can do about this other than wrap it with an if( exists( pos ) )

## Types	
- NULL isn't defined, therefore I can't perform any conditional behavior surrounding

	```
	if( this ){ ... }
	//or
	if( parentof(this) ){ ... }
	```
	- or anything regarding Printf() because of incompatible types
	which makes writing time-saving [trace methods](scaffolds/Warning.bt) to debug
	[complex objects](filetypes/Audio/InstrumentSet.bt)
- There's no `string typeof()` function so handling a situation where we perform
	an operation based on a parent is hard.
## Structs
- Can't declare a local struct, meaning:
	- assemble complex structures without disk IO
	- create a workable copy of data without transforming it
	- pass around an organized set of data in lieu of objects/classes
- Bitfield padding does not extend beyond structure boundaries, all data must be at least
	a byte wide, otherwise [sophisticated hacks and workarounds are in order](filetypes/Texture/i4.bt). 
	And even those have their practical limits.
- Can't be bitfielded, even if its size reports itself as 1 and all elements declare which bits
	they use accordingly.
- Sizes can't be reported as a float or in quantities of bits. This is a major architecture thing,
	but it's significant enough to warrant requesting due to the number of ways
	people find places to hide significant bits in files.
- A custom type spanning several bits or even overlapping with bits from another type cannot 
	be created. This impacts densely packed data that necessitates a read/write function for
	manipulation the most.
- If a byte could be abstracted to a lower level unit like a bit array or if bitfielded arrays
	applied the bitfielding to each element of the array without padding enabled this could be
	worked around at some level.
## Enums
- You cannot pass a generic enum in a function. This makes generic trace functions difficult, example:

	```C
	void AssertKnownEnum( enum e, string msg ){
		local string omsg;
		local string enumerated = EnumToString( e );
		SPrintf(omsg, "%s had an unknown value %d", msg, e);
		Assert( enumerated != "", omsg);
	}
	```
	
	With its ideal call being:
	
	```C
	enum <short> WATER_PROPS {
        WATER_PROP_NORMAL       = 0x0100,
        WATER_PROP_ABNORMAL     = 0x0102,
        WATER_PROP_CAMERAMESSER = 0x0105,
    } maybeWaterPropertiesOrCameraEffects;
	
	AssertKnownEnum( 
        maybeWaterPropertiesOrCameraEffects,
        thisName+"->maybeWaterPropertiesOrCameraEffects"
    );
	```
	
	- leaving the only workaround looking like:
	
	```C
	void AssertKnownEnum2( string e, uint64 d, string msg ){
		local string omsg;
		SPrintf(omsg, "%s had an unknown value 0x%04LX", msg, d);
		NLAssert( e != "", EXSWarning(omsg));
	}
	AssertKnownEnum2( 
        EnumToString( maybeWaterPropertiesOrCameraEffects ),
        maybeWaterPropertiesOrCameraEffects,
        thisName+"->maybeWaterPropertiesOrCameraEffects"
    );
	```
	
	
## Attributes
Currently, there's some asymetry in the availability of attribute functions at runtime:
```
< format=hex|decimal|octal|binary,
 fgcolor=<color>,
 bgcolor=<color>,
 comment="<string>"|<function_name>,
 name="<string>"|<function_name>,
 open=true|false|suppress,
 hidden=true|false,
 read=<function_name>,
 write=<function_name>
 size=<number>|<function_name> >
```
- There's no handy way to get the attribute functions for something when you have
	a reference to the structure via "this" but not the size or name functions
	a way to do "local string theName = GetName(unspecifiedType)" would be handy
	for writing macros that give heirarchy dependent data

## Functions
- EnableRelativeReads(); DisableRelativeReads(); so that ReadUInt(+1); or ReadUInt(-10);
	would work without having to invove FTell() every time

## Collaboration
- It's hard to provide a repo that "just works" with per-project settings, when you have
	to set an "Includes" directory, manually add niche scripts to the scripts folder,
	or define which [Inspector.bt](Inspector.bt) template to use.
	
# Templates
## Includes
Feel free to ignore most of these, as I'm spoiled by [lua's flexible require function](http://www.lua.org/pil/8.1.html).
Most of this is because I want to write reusable parts without indulging in the
CRUFT-generating patterns that surround header files.
- Includes don't attempt to process includes relative to their own file,
	only the PWD or the paths listed. While true to C form, this makes it difficult
	to write reusable components.
- Including strings provided by #define statements doesn't work in either:

	```
	#define INC "src/example.bt"
	[... elsewhere ...] 
	#include INC
	```
	
	or
	
	```
	#define INC #include "src/example.bt"
	[... elsewhere ...]
	INC;
	```
	
- Including dynamically created strings won't work. That's how preprocessors work, that's fair.
- RunTemplate() runs in post-processor scope 
	
# Interface
- No code collapse for particularly large control statements make things tough for [HeaderCommand.bt](filetypes/Scene/HeaderCommand.bt)
	lookups. Having to run a separate "name" / "comment" function 

# API
This part is a bit bigger, because it was asked that I give you an idea of what I would expect.
The general use-case for a starter API would be in two major areas:
- Executing templates that are not limited to traditional control flows presented by templates.
- Running scripts that interact with the interface and data to do sophisticated things like using
	libraries native to their environment or provide visualizations.
For the most part, the API only needs to be capable of receiving data from templates and some basic interface functions like setting the background color. The most basic way of communicating between two applications is via a TCP socket. There are a lot of bindings for this.
- [python tcp](https://wiki.python.org/moin/TcpCommunication)
- [python tcp pt2](http://woozle.org/~neale/papers/sockets.html)
- [google protocol buffers](https://developers.google.com/protocol-buffers/?hl=en)
- [LuaSocket tcp](http://w3.impa.br/~diego/software/luasocket/tcp.html)

The most important thing is to be able to pass template variables back and forth. Encoding structs as JSON seems to be the most universal way to effectively communicate heirarchial data back and forth. 
- In [lua JSON](http://lua-users.org/wiki/JsonModules) can more or less unfold to native data types.
- [python JSON](https://docs.python.org/2/library/json.html) can make dictionaries.

The following binary template can be expressed in JSON as:
```c
typedef struct {
	short X, Y, Z;
} ShortVec;

ShortVec shortVec;
```
JSON
```json
[{
    "ShortVec shortVec": {
        "Y": 1600,
        "X": 1183,
        "Z": 1200
    }
}]
```
Which, when encoded as a networked message, could be high level:
```json
{
    "type": "template_variable",
    "data": {
        "shortVec": {
            "Y": 1600,
            "X": 1183,
            "Z": 1200
        }
    },
    "__meta": {
        "shortVec": {
            "type": "ShortVec",
            "size": 6,
            "raw": "BkAExbgEwrA=",
            "__meta": {
                "X": {
                    "__meta": {
                        "type": "short",
                        "size": 2,
                        "raw": "BkA="
                    }
                },
                "Y": {
                    "__meta": {
                        "type": "short",
                        "size": 2,
                        "raw": "BMW4"
                    }
                },
                "Z": {
                    "__meta": {
                        "type": "short",
                        "size": 2,
                        "raw": "BMKw"
                    }
                }
            }
        }
    }
}
```
The data itself could be encoded in a number of ways, depending on how 010 works:
- [c serialization](http://troydhanson.github.io/tpl/index.html)
- [another c serialization lib](http://s11n.net/c11n/)
- [Eet data serialization with lua/python/etc bindings](https://www.enlightenment.org/about-efl)
- [lua FFI](http://luajit.org/ext_ffi.html)

I would personally prefer JSON over TCP because of the availability of libraries to support those things. 
My two most preferable use cases are through:
- [LÖVE](https://love2d.org/) which is a lua environment with luasock, luajit and FFI. This allows me to easily visualize complex data like 2D textures, 3D models, or create objects that can be manipulated without the restrictions of templates. Due to having FFI support, I can share code between my templates and the visualization environment meaning I don't have to reimplement or port any data. [This repo is an example of using FFI to read c structs directly](https://github.com/excessive/iqm).
- [Python](https://www.python.org/) which is, python. Between the cstructs and struct module it could do just about everything lua can but without sharing much with the templates.

# Bits & Reads
- A struct that is only four bits long will not have its background set right because the next
	four bit structure will technically be of size zero.
- Since there are no handy functions for basic bit manipulation like:
	- ReadUByte with a number of bits supplied, to take into consideration the current 
		endianess, bitfield padding settings, and bitfield ltr/rtl order
	- Getting the state of bitfield padding before creating a type that requires bitfieldin
		so it can be returned to normal if it were a template that should be included frequently
- The ability to "Push" and "Pop" the current program states w/r/t:
	- Bitfield settings mentioned above.
	- Current color settings.
	- Anything that acts as a global flag.
- A keyboard shortcut to copy the current cursor position into the clipboard would rock, kinda like [this](scripts/CurPosInHex.1sc).
- The ability to, on error, expand and highlight the last good template variable.
- A meaningful stack trace would be cool, because generating these by hand require lots of strings and macros.
	- eg: Error in struct MyArchive[0] -> struct MyFile[31] -> byte property
	- This speeds up jumping to the nth entry in a long array of structs 
- VarArg assertions and prints would be neat, Printf()-ing a struct should use the same read function
	that a type gets for its display.
- It's easy to go off the rails when you disable bitfield padding, this isn't usually a problem
	but it does mean that when your struct ends a couple bits short, you can't use its size
	to check if you goofed. [Sometimes this can get hairy.](filetypes/Scene/HC/ZHC_Collision.bt)

# Search
- Doing a regex search pulls the whole string into the value column, making an export mostly useless.
	If I want to extract all the strings I found then I have to manually define them somewhere or copy and
	paste them into a separate file. The value should just be the value.