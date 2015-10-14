# To Do
A handy file that lists everything that must be done, ever.

## Template Based
If it relates to refactoring templates or styles to enforce, then it should happen here.
### Housekeeping
* Bring up any stray TODOs in the files here.
* Clean out unused / copypasted code.
* Get some standards.
### Find Data
* Scrounge around for source code from other tools, particularly files of type .cs, .h, or .py -- I don't want to reverse a source-less tool unless I'm absolutely stumped.
### Following The Rules
* Remove instances of data that was defined as part of the template, this throws off counts.
* Agnosticize certain files into .h files where it can be done via #defines.
* Make #defines for whether a template is being run against a full ROM or whether it's being run within the scope of a sub-virtual-file.
* Replace struct variables with parentof(this) or startof(parentof(this)) where possible.
### Measuring Progress
* Convert structures to be On-Demand with non-conflicting size functions.
* Write more assertions for the existing data types to ensure we understand it and to track anomolies.
### Coloring Book
* Make a flag/#define for setting bookmarks in the file.
* Make a SIGNIFICANT macro that cycles between primary colors to prevent 
	* Per-line color-changing.

## Coverage Based
Let's fill these in. If a header is missing a significant child, put it there.
A @ indicates that it is just a child reference to a global file type, so that ancestor-specific data can be included.
- [ ] Scenes
	- [ ] Environment Vars
	- [ ] Collision
	- [ ] Cutscenes
	- [ ] @ Rooms
- [ ] Rooms
	- [ ] @ Geometry
	- [ ] @ Textures
- [ ] Overlays
	- [ ] Actors
- [ ] Objects
	- [ ] Animations
	- [ ] @ Textures
	- [ ] @ Geometry
- [ ] Text
- [ ] Skyboxes
- [ ] Compressed Data (Yaz0)
- [ ] Geometry
- [ ] Textures
	- [ ] Palettes
	- [ ] Image Data
		- [x] JFIF / JPEG
		- [ ] ???