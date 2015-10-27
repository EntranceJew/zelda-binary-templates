MAJOR BUGS:
* Every time I open the tools window and save it crashes. :(

THINGS I WANT FROM 010 EDITOR:
# Bookmarks
* Bookmarks for structs with arguments fail because they are missing arguments,
	this could be mitigated by providing a type-suggested UI based on a function
	signature and AddBookmark being a VarArg()
* (could be scripted) A keyboard shortcut to define a bookmark inside a bookmark inside the existing one,
	splitting it in half and resuming where the last one left off would be good.
	Sometimes I bookmark a uchar range that contains lots of data to easily create
	and lock my selection when searching, but once I find significant data inside this
	I cannot make note of it within the application and have to use an external tool.
* AddBookmark doesn't process template instructions like Printf's in the output panel.
	This usually isn't too bad, because if a file were to be processed 
* 
# Inspector
* If I have a custom inspector file and it is using a type defined elsewhere, and that
	type implements its own sub-type, when reading the data it generates alerts that
	it has exceeded the end of the file. This is minor, but distracting. For larger types,
	or structures this could be hard to work around, to do a safe read before declaring itself.
	It also seems easily avoidable because it attempts to call the read function even if the
	size would show that it doesn't have enough room.
	It seems to only happen to structures / typedefs that utilize a read function.
* Occasionally, when trying to follow suit of the default Inspector / reloading it, it
	complains that the variable pos has already been defined. I don't think there is
	anything I can do about this other than wrap it with an if( exists( pos ) )

# Types	
* NULL isn't defined, therefore I can't perform any conditional behavior surrounding
	```
	if( this ){ ... }
	//or
	if( parentof(this) ){ ... }
	```
	or anything regarding Printf() because of incompatible types
	which makes writing time-saving [trace methods](scaffolds/Warning.bt) to debug
	[complex objects](filetypes/Audio/InstrumentSet.bt)
* There's no `string typeof()` function so handling a situation where we perform
	an operation based on a parent is hard.
* 
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
# Attribute Helpers
Currently, there's some asymetry in the availability of attribute functions at runti

# Variable Attributes
* There's no handy way to get the attribute functions for something when you have
	a reference to the structure via "this" but not the size or name functions
	a way to do "local string theName = GetName(unspecifiedType)" would be handy
	for writing macros that give heirarchy dependent data

# Functions
* It hurts to have to bang out an overload for every permutation of a basic type.
	It would be nice if there were abstract "string" and "number" and 
* EnableRelativeReads(); DisableRelativeReads(); so that ReadUInt(+1); or ReadUInt(-10);
	would work without having to invove FTell() every time

# Collaboration
* It's hard to provide a repo that "just works" with per-project settings, when you have
	to set an "Includes" directory, manually add niche scripts to the scripts folder,
	or define which [Inspector.bt](Inspector.bt) template to use.
	
# Templates
## Includes
Feel free to ignore most of these, as I'm spoiled by [lua's flexible require function](http://www.lua.org/pil/8.1.html).
Most of this is because I want to write reusable parts without indulging in the
CRUFT-generating patterns that surround header files.
* Includes don't attempt to process includes relative to their own file,
	only the PWD or the paths listed. While true to C form, this makes it difficult
	to write reusable components.
* Including strings provided by #define statements doesn't work in either:
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
* Including dynamically created strings won't work. That's how preprocessors work, that's fair.
* RunTemplate() runs in post-processor scope 
	
# Interface
* No code collapse for particularly large control statements make things tough for [HeaderCommand.bt](filetypes/Scene/HeaderCommand.bt)
	lookups. Having to run a separate "name" / "comment" function 

# API
This part is a bit bigger, because it was asked that I give you an idea of what I would expect.
The general use-case for a starter API would be in two major areas:
	* Executing templates that are not limited to traditional control flows presented by templates.
	* Running scripts that interact with the interface and data to do sophisticated things like using
		libraries native to their environment or provide visualizations.
[python tcp](https://wiki.python.org/moin/TcpCommunication)
[python tcp pt2](http://woozle.org/~neale/papers/sockets.html)
[google protocol buffers](https://developers.google.com/protocol-buffers/?hl=en)

[c serialization](http://troydhanson.github.io/tpl/index.html)
[another c serialization lib](http://s11n.net/c11n/)
[Eet data serialization with lua/python/etc bindings](https://www.enlightenment.org/about-efl)

For the most part, this consists of:
	* Reading and writing data to the application bound to the defined structures & templates.
	* Manipulating the interface 
# Bits & Reads
* A struct that is only four bits long will not have its background set right because the next
	four bit structure will technically be of size zero.
* Since there are no handy functions for basic bit manipulation like:
	* ReadUByte with a number of bits supplied, to take into consideration the current 
		endianess, bitfield padding settings, and bitfield ltr/rtl order
	* Getting the state of bitfield padding before creating a type that requires bitfieldin
		so it can be returned to normal if it were a template that should be included frequently
* The ability to "Push" and "Pop" the current program states w/r/t:
	* Bitfield settings mentioned above.
	* Current color settings.
	* 
* A keyboard shortcut to copy the current cursor position into the clipboard would rock.
* The ability to, on error, expand and highlight the last good template variable.
* A meaningful stack trace would be cool, because generating these by hand require lots of strings and macros.
	* eg: Error in struct MyArchive[0] -> struct MyFile[31] -> byte property
	* This speeds up jumping to the nth entry in a long array of structs 
* VarArg assertions and prints would be neat, Printf()-ing a var should use the same read function
	that a type gets for its display.
# Search
* Doing a regex search pulls the whole string into the value column, making an export mostly useless.
	If I want to extract all the strings I found then I have to manually define them somewhere or copy and
	paste them into a separate file. The value should just be the value.