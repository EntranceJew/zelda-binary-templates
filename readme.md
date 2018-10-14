# Zelda Binary Templates
Did you know? N64 Zelda games (and maybe other zelda games!) are composed of many smaller file types?
If you crack open the ROM you can slurp up that data like some sort of oyster and or egg.

![look at that template go](http://i.imgur.com/i27WJvD.png)

These binary templates aim to cover the gaps in our knowledge by allowing us to explore the data.
When we can see a byte here or there is being skipped or ignored, we can easily tell what is or isn't being used.

![previewing image data](https://i.imgur.com/l7U0BuH.png)
_Using the power of templates, we're able to view certain image data exactly as it appears in the ROM without any external tools. [Click here to see a gif of viewing even more image data!](https://i.imgur.com/JuCNQIi.gif)_

## Binary Templates? 010 Editor?
If you don't know what [010 editor](http://www.sweetscape.com/010editor/) is and you've been using a hex editor pretty frequently,
I suggest you try it out. (Plus this repo is mostly useless without it.) If you have it or you can read C structures,
then dive in to the [binary templates](http://www.sweetscape.com/010editor/templates.html) and check out the Important Files section below to get a lay of the land.
If you don't know what any of this is, then I suggest you try out 010 with this repo using the guide linked below.

## [Quickstart Guide](docs/quickstart_guide.md)
If you're new to 010 editor or want to get a better picture of how to use this repo, head over to the [Quickstart Guide](docs/quickstart_guide.md).

# [To Do](todo.md)
Help in any way you think you can. Check out the [todo.md](todo.md) to see if there's anything that you might be able to take a swing at. Just give me a heads up if you do, that way I can plan around that. I suggest experimenting around a little, but when you're ready -- check out [CONTRIBUTING.md](CONTRIBUTING.md).

# Assumptions
* This repo usually focuses around MM first and OoT second, which is contrary to most existing documentation.
* If unspecified, all of the offsets presented will be for the debug version of the related ROM.
* If unspecified, all or most of the offsets presented will be for the decompressed version of the related ROM.

## ROM Names
I tend to reference ROMs by a shorthand name, the full stats of any ROM I work with are listed in [the checksums directory](checksums/).

### Majora's Mask
* `dMM_E_debug.z64` is shorthand for a ROM that matches [these checksums](checksums/decompressed/Legend%20of%20Zelda%2C%20The%20-%20Majora's%20Mask%20(E)%20(M4)%20(Debug%20Version).z64.csv)

### Ocarina of Time
* `dOoT_MQ_E_debug.z64` is shorthand for a ROM that matches [these checksums](checksums/decompressed/Legend%20of%20Zelda%2C%20The%20-%20Ocarina%20of%20Time%20-%20Master%20Quest%20(E)%20(GC)%20(Debug%20Version).z64.csv)

# Important Files
* [autoload.bt](autoload.bt) because of nested `#include` restrictions, all includes have go here. Primarily organized alphabetically, and then by dependence. Begins with common scaffolds, then other filetypes.
* [skeleton.bt](skeleton.bt) is a generalized structure that can be included after autoload, it makes use of hardcoded addresses and structure sizes to jump around and read things like the filesystem, scenes, and actor lists. This should always included before any other template variables are defined.
* [Inspector.bt](Inspector.bt) because there are so many small structures, I recommend replacing the default Inspector with this so you can recognize would-be data types at a glance. Makes use of some files in the root of the filetypes folder.

* [checksums/](checksums/) contains CSVs named after the full ROM name that contain the checksums for said ROM. Use this to verify against shorthand ROM names and that one of us has the right ROM.
* [templates/](templates/) contains files named after the shorthand ROM name for each game and version. Use these as your entry point on ROMs.
* [docs/](docs/) a ton of files for getting up to speed, some scratch notes but others are more valuable.
* [filetypes/](filetypes/) anything that is a small identifiable structure belongs in here. If it's a bigger file type made of many smaller structures (like Scenes) then it gets its own folder.
* [scaffolds/](scaffolds/) a collection of small utility templates that are referenced nearly everywhere. This ranges from automatic color assignment to bit structs or 
	* [Anomaly.bt](scaffolds/Anomaly.bt) contains useful assertions such as ensuring bytes are null, within numeric ranges, and that enums have definitions. Merely prints warnings with a trace, does not stop execution.
	* [Assert.bt](scaffolds/Assert.bt) provides assertion wrappers, functions like Anomaly but all failed asserts will hault execution.
	* [Bits.bt](scaffolds/Bits.bt) provides handy wrappers for bit functions like reading N bits from a byte without assignment or bit shifting and a byte-sized struct consisting of eight single-bit variables named `BitEight`.
	* [Block.bt](scaffolds/Block.bt) jumps to a location and allocates a predefined amount of space.
	* [Bucket.bt](scaffolds/Bucket.bt) provides a method to store values and provide a histogram of their usages. Use `Bucket(var)` to scoop for values, `ClearBucket()` to empty it, and `ReportBucket()` to print information.
	* [Colors.bt](scaffolds/Colors.bt) defines extra color constants and allows manipulating tuples of colors as ints and the other way around.
	* [Jumps.bt](scaffolds/Jumps.bt) enables saving and restoring the FTell() location with a stack.
	* [Padding.bt](scaffolds/Padding.bt) provides a struct to align to the nearest column index for variable sized widths. Also provides a NullEater to consume null bytes. Should not be used in place of `zeroes[]`.
	* [Significant.bt](scaffolds/Significant.bt) provides colorization on a per-variable basis to make them stand out from one another. Changes color grades when entering / exiting structures.
	* [Unknown.bt](scaffolds/Unknown.bt) handles alerts and traces for unknown variables. Processing this is temporarily disabled, replace `#define UNK NOP()` with `#define UNK AlertUnknownData()` to re-enable.
* [scripts/](scripts/) this is for code that operates on variables provided by the templates. Stuff like extracting Yaz archives, exploding and reassembling the ROM, or correcting save checksums go here. It is also for scripts that extend 010's functionality in some way.
	* [CurPosInDec.1sc](scaffolds/CurPosInDec.1sc) puts the cursor position in the file in your clipboard in decimal form.
	* [CurPosInHex.1sc](scaffolds/CurPosInHex.1sc) puts the cursor position in the file in your clipboard in padded hex, I suggest putting this on a keyboard shortcut.
	* [DumpAllYaz.1sc](scaffolds/DumpAllYaz.1sc) extracts all yaz archives in a file with the variable name "arc" to a user specified folder.
	* [FixSaveMM.1sc](scaffolds/FixSaveMM.1sc) recalculates the checksum for a MM save.
	* [FixSaveOoT.1sc](scaffolds/FixSaveOoT.1sc) recalculates the checksum for a OoT save.
