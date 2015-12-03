# To Do
A handy file that lists everything that must be done, ever.

# Things To Not Do
* Write general goals that are guidelines that don't list everything that needs to be addressed.

# Best Ideas
* Import datasources from the spreadsheet into a data folder that can be processed into
	template parts, lookups for names and comments, and externally useful data (wiki modules).

# Scaffolds
* [Trace.bt](/scaffolds/Trace.bt)
	* Consume `thisName` and generate a stack using arrays-of-strings.
	* Track depth, variable number, starts ends and sizes.
	* These need to be made use of by [Anomaly.bt](/scaffolds/Anomaly.bt) and [Assert.bt](/scaffolds/Assert.bt).
* [Unknown.bt](/scaffolds/Unknown.bt)
	* Make use of the thisName convention for traces, same as asserts/warns.
	* Work with the SIBE/SIEND/SIT for UNK to auto-provide unknown variable names.
	* Use the distance between a SIT and an UNK to estimate coverage automatically.

# Templates
* [Yaz.bt](/filetypes/Compressed/Yaz.bt)
	* Could use some fixing up, using bit reads instead of its current logic.
* [N64ROMHead.bt](/filetypes/N64ROMHead.bt)
	* Finish this, mark it up, use the endianess flag in the template.
	* Write a script to correct the CRCs.
* [Actor.bt](/filetypes/Overlay/Actor.bt)
	* Finish resolving the logic for relocation pointers. (1/4)
* [Overlay/Files](/filetypes/Overlay/Files/)
	* Locate more pure-data structures and write templates for them.
* [Texture](/filetypes/Texture/)
	* Bring up to speed with standards for struct metadata.
	* Add a flag somewhere to enable/disable variable colorization.
	* Correct JFIF image coloration code (either very wrong or too big to decipher).
* Scanners Patterns
	* Examples:
		* [Scene](/filetypes/Scene/) (3/32)
			* Vet good data, nuke bad data.
		* [DisplayList](/filetypes/DisplayList/) (2/256)
		* [MIPS](/filetypes/MIPS/) (2/512)
		* [NIFF](/filetypes/NIFF/) (6/20)
	* Write objects for the many remaining commands.
	* Correct the scanner / enums accordingly.

# Scripts
* Write a handy macro for comparing two like structures using [science](http://www.sweetscape.com/010editor/manual/FuncTools.htm#Compare).
* Make a flag/#define for setting bookmarks in the file.
* Write a macro to report which VFS file the cursor is currently inside.
* Make it so that SIBE / SIEND add "thisName" to a debug stack.
	* Make assert functions utilize this behavior / standard.
* [DumpAllYaz.1sc](/scripts/DumpAllYaz.1sc)
	* Make a general Export method for Yaz files and not just archives of them.
	* Write helpers for SAVE/RESTing the current file and potentially preserving template vars.
	* Use Memcpy instead of iteration.

# Find Data
* Scrounge around for source code from other tools, particularly files of type .cs, .h, or .py -- I don't want to reverse a source-less tool unless I'm absolutely stumped.
* Cross-reference checkums and junk with places like No-Intro, GoodN64, MAME's N64 softwarelist.