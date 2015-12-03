# Generic Functions
You can define simply "struct" to perform operations on generic types in functions.
The following is valid:
```
typedef struct {
	ubyte weight;
	string name;
	ubyte age;
} Egrid;

typedef struct {
	string nickname;
	uint size;
	ubyte age;
} Elephant;

string GetStructName(struct anything){
	if( exists(anything.name) ){
		return anything.name;
	} else if( exists(anything.nickname) ){
		return anything.nickname;
	}
}

int DoesHaveStupidName(string name){
	case "hotdog salesman"
	case "mister wigglesworth the third":
		return 1;
		break;
	case "derrike":
		return 0;
		break;
	default:
		return -1;
		break;
}

// running it
Egrid myBird;
Egrid someoneElsesBird;
Elephant myDog;
Elephant rabidDog;

local int i;
local string name;
for( i = 0; i < 3; i++ ){
	switch(i){
		case 0:
			name = GetStructName(myBird);
			break;
		case 1:
			name = GetStructName(someoneElsesBird);
			break;
		case 2:
			name = GetStructName(myDog);
			break;
		case 3:
			name = GetStructName(rabidDog);
			break;
		default:
			name = "unloved thing";
			break;
	}
	
	if( DoesHaveStupidName(name) ){
		Printf("stupid name detected: %s\n", name);
	}
}
```
## Benefits
- If your data has some stuff in common or some stuff in almost-common, you can write
	a set of generic handlers to access members or perform certain operations.
	This is handy when unions won't cut it.
- This also works on typedef'd structs.

## Limits
- This doesn't enable access to locals defined in the variable's scope, so it can't 
	utilize offhand access to data outside the scope of a local.
- Yes

# Size
Despite [what the docs may say](http://www.sweetscape.com/010editor/manual/Sizeof.htm),
	the sizeof() function works fine on complex structs IF they have a size function.

# Reading Locals
The function attribute "read" has access to locals, accessed through structure attributes.

# Structure Bloat
Does generating an array of your custom structs create a line for each entry?
Don't have time to make it on-demand?
Stick that baby in a disposable struct and get some (not at all) free heirarchy:
```C
struct {
	Items items[192];
} AllOfTheseItems;
```

# Identifying Data At A Glance (Zelda Specific)
## Alignment & Colors
u data-ing good
http://i.imgur.com/zHacyVR.png
u probably fucked something up
http://i.imgur.com/ZPpHoLp.png
almost there, hard edges
http://i.imgur.com/Z1iVEVs.png

to fuck the data up like this:
jump to `TERRAIN_TRIGGER_RESET` and `TERRAIN_HURT_FIRE` inside `ZHC_Collision`
and remove only one of their bitfield paddings for light fuckuppery
remove them both to take them off the fuckin' rails

### Keep In Mind
* Not all data is guaranteed to align, there are cases of structures with
	3 integers and no padding.

# Identifying Data At A Glance (Zelda Specific)
Sometimes there are some patterns you can keep a look out for.

## RAM Pointers
Often, data in the code block will contain hex data that looks like `80 15 91 D8`.
Any four-byte sequence that starts with `80` is likely a RAM pointer, as `80` is where
the addresses start for RAM in the N64 memory map. 

## File Offsets
Sometimes, you'll see data like `01 E1 93 D1`. 
The debug ROMs, when decompressed, have their final byte at `03 FF FF FF`.
Any data lower than that has the potential of being a pointer to other data directly.
(This is usually looked up against the VFS to find the physical address in non-compressed ROMs.)