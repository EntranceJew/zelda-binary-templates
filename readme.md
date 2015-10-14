# Majora's Mask Binary Templates
Did you know? Majora's Mask (and other zelda games!) are composed of many smaller file types?
If you crack open the ROM you can slurp up that data like some sort of oyster and or egg.

These binary templates aim to cover the gaps in our knowledge by allowing us to explore the data.
When we can see a byte here or there is being skipped or ignored, we can easily tell what is or isn't being used.

## Binary Templates?!
If you don't know what [010 editor](http://www.sweetscape.com/010editor/) is and you've been using a hex editor pretty frequently,
I suggest you try it out. (Plus this repo is mostly useless without it.) If you have it or you can read C structures,
then I guess dive in to the [binary templates](http://www.sweetscape.com/010editor/templates.html).

## Important Files
* **main.bt** is usually a pretty rough map of the full ROM. That rom being either the MM debug ROM (deflated).
* **Inspector.bt** because there are so many small structures, I recommend replacing the default Inspector with this so you can recognize would-be data types at a glance.
* **scripts/** one-off hotbar commands like getting the current cursor position go here. Later there will be more advanced scripts.
* **scraps/** sometimes you need to focus on one particular thing, these files are meant to be like main.bt but for only the relevant data blobs. Sometimes these don't take place in the MM ROM and instead take place in the OoT MQ debug (deflated) ROM.
* **regions/** similar to scraps, these focus on files in the virtual file system.
* **filetypes/** anything that is a small identifiable structure belongs in here. If it's a bigger file type made of many smaller structures (like Scenes) then it gets its own folder.

## Contributing
Go hog wild.