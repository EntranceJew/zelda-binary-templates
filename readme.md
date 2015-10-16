# Zelda Binary Templates
Did you know? N64 Zelda games (and maybe other zelda games!) are composed of many smaller file types?
If you crack open the ROM you can slurp up that data like some sort of oyster and or egg.

These binary templates aim to cover the gaps in our knowledge by allowing us to explore the data.
When we can see a byte here or there is being skipped or ignored, we can easily tell what is or isn't being used.

## Assumptions
* This repo usually focuses around MM first and OoT second, which is contrary to most existing documentation.
* If unspecified, all of the offsets presented will be for the debug version of the related ROM.
* If unspecified, all or most of the offsets presented will be for the decompressed version of the related ROM.

## [To Do](todo.md)
Help in any way you think you can. Check out the [todo.md](todo.md) to see if there's anything that you might be able to take a swing at. Just give me a heads up if you do, that way I can plan around that.

## Binary Templates?!
If you don't know what [010 editor](http://www.sweetscape.com/010editor/) is and you've been using a hex editor pretty frequently,
I suggest you try it out. (Plus this repo is mostly useless without it.) If you have it or you can read C structures,
then I guess dive in to the [binary templates](http://www.sweetscape.com/010editor/templates.html).

## ROM Names
I tend to reference ROMs by a shorthand name, the full stats of any ROM I work with are listed in [the checksums directory](checksums/).
### Majora's Mask
* `dMM_E_debugD.z64` is shorthand for a ROM that matches [these checksums](checksums/decompressed/Legend of Zelda, The - Majora's Mask (E) (M4) (Debug Version).z64.csv)
### Ocarina of Time
* `dOoT_MQ_E_debugD.z64` is shorthand for a ROM that matches [these checksums](checksums/decompressed/Legend of Zelda, The - Ocarina of Time - Master Quest (E) (GC) (Debug Version).z64.csv)

## Important Files
* [main.bt](main.bt) is usually a pretty rough map of the full ROM. That rom being either the MM debug ROM (deflated).
* [Inspector.bt](Inspector.bt) because there are so many small structures, I recommend replacing the default Inspector with this so you can recognize would-be data types at a glance.
* [scripts/](scripts/) one-off hotbar commands like getting the current cursor position go here. Later there will be more advanced scripts.
* [bookmarks/](bookmarks/) lists a bunch of shorthand ROM names and then a set of bookmarks described by the filename in CSV format. Any data that is missing representation as a data structure is presented as a uchar byte array the length of the block.
* [checksums/](checksums/) contains CSVs named after the full ROM name that contain the checksums for said ROM. Use this to verify against shorthand ROM names and that one of us has the right ROM.
* [scraps/](scraps/) sometimes you need to focus on one particular thing, these files are meant to be like main.bt but for only the relevant data blobs. Sometimes these don't take place in the MM ROM and instead take place in the OoT MQ debug (deflated) ROM.
* [regions/](regions/) similar to scraps, these focus on files in the virtual file system.
* [filetypes/](filetypes/) anything that is a small identifiable structure belongs in here. If it's a bigger file type made of many smaller structures (like Scenes) then it gets its own folder.