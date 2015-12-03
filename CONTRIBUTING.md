# Contributing
These aren't absolute musts, but they really help out. The current codebase might not obide 100% by all these, but you could help make it.

## [Ensure You're Set Up](docs/quickstart_guide.md).
Checking the [Quickstart Guide](docs/quickstart_guide.md) might answer questions you had before you knew you had them.

## Code Style
* You should always import [autoload.bt](/autoload.bt). It has important scaffolds and takes virtually no processing time, plus it sets your template's endian and bitfields up right. If you are bothered by the default colors, use the macro `SIOFF;` to disable coloring and `SION;` to turn it back on.
* FSeek as little as possible, and when you do, use the macro `SAVE;` before doing so and `REST;` after allocating all the bytes necessary. This will push the current position to a stack and then pop after returning to the stored location.
* If you are certain you have an individual variable, put `SIT;` on the line before it to change the color automatically.
* If you have bytes in a struct that are unknown, put `UNK;` on the line before them. This makes it easier to find and report them later.
* Traditionally, an unknown is declared as `ubyte unknown[numBytes];` where the name gets a number in the event of more unknowns, e.g. `ubyte unknown2[numBytes];`.
* The naming conventions for unknowns apply to bytes anticipated to be null, expressed as `ubyte zeroes[numBytes];`. After declaring a ubyte array of zeroes, the line after it should contain `AssertUBytesZero( zeroes, thisName+"->zeroes");` to hault execution in the event padding is misaligned.
* Macros like `UNK;` and `SIT;` are decorators, put them on the same line with a space between them in that order when convenient.
* If an enum has unknown values or holes in it, explicitly define each value and leave the comment `// ...` where holes are. This way we can raise warnings when an enum has an unknown value.
* Whenever possible, try to use `startof()` instead of storing a location in memory. The same goes for using `sizeof(this)` for finding the end of a structure.
* Try to use `parentof()`, but only when a structure has a simple lineage or whatever behavior utilizing it is operating on abstract / common  values.
* Structures should begin with `local string thisName = "ThisStructName";` so the info can be obtained pragmatically.
* After a structure's thisName, use the macro `SIBE;` to signify the beginning of a structure. `SIEND;` should be the last variable in your structure.
* If you're reading bits into a temporary variable, you should use the `Read*Bits()` functions provided by [Bits.bt](/scaffolds/Bits.bt) to reduce the number of bit shifts in the source.
* By default, running a template shouldn't print any text unless a function is included somewhere to print. Printing text should be done through scaffold-based methods.

## Git Flow
1. Check for [existing issues](https://github.com/EntranceJew/zelda-binary-templates/issues) in the repo.
2. If the issue requires a bigger change you may want to submit the issues without the necessary changes first, so we can confirm the issue and know that you're working on fixing it. You should also create a WIP (work in process) pull request prefixed with ``[WIP]`` early so we can already start reviewing them.
3. Fork the project, clone it and make your changes in an extra branch with a proper branch name `bugfix/`, `patch/`, `feature/`. Make sure you're up to date with master before making a new branch.
4. Make sure your changes don't raise any extra assertions.
5. Submit the pull request with a short summary what you've changed.
6. If you make additional changes, push new commits to your branch. **Do not squash your changes**, that makes it extremely hard to see what you've changed compared to the previous version of your pull request.