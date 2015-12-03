# Everything I Found I Was Too Lazy To Write Down
Chances are if text ends up here, I already talked about it in IRC elsewhere.
If text gets promoted to this location it means that the templates are more accurate than wikis in some cases.

# Scenes and Rooms
* Most if not all [unknown header commands](filetypes/Scene/HeaderCommand.bt) accept a number, two bytes of null, and then a scene-local [ZBank](filetypes/Banks.bt).
* Collision data for rooms use densely packed bits for flags, the wiki clumps things by the byte and overlooks certain flags.

# Audiobank
* Most of these structures don't have strong documentation and DeathBasket's site is missing some data.
* In MM, the 4th sample bank is not referenced directly. It sounds like it only contains one voice clip and garbage data, as it's not big enough for many other samples after that.