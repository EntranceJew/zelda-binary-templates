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