
# Quickstart Guide
1. Download and install [010 editor](http://www.sweetscape.com/010editor/).
2. Clone this repository.
3. Set your 010 includes path.
	1. Open `Tools > Options`.
	2. Select `Compiling`.
	3. Change `Includes:` to be [the path you cloned your repository to](http://i.imgur.com/DW1bSqa.png).
4. Set your 010 inspector template.
	1. Open `Tools > Options`.
	2. Select `Inspector`.
	3. Change `Auto Inspector` to `Use Custom Template`.
	4. Change the path to be [the Inspector.bt at the root of the path you cloned your repository to](http://i.imgur.com/iXeIRG5.png).
5. Import custom 010 scripts.
	1. Open `Tools > Options`.
	2. Select `Compiling > Scripts`.
	3. Click `New` and add an entry for each [file in the scripts folder at the root of the path you cloned your repository to](http://i.imgur.com/eqvEA5Q.png).
6. Use `File > Open File...` to open the ROM of your choice.
7. Validate the checksums of your ROM.
	1. With the ROM open in 010, Open `Tools > Check Sum ...`
	2. In the [options panel](http://i.imgur.com/DgafBn7.png) ensure that `Entire File` is selected and all the hash methods are checked.
	3. Click `Ok`. When this is done, the `Checksum` panel of the `Output` pane [will have checksums](http://i.imgur.com/LOuKcr6.png).
	4. Ensure that the checksums you just generated match with the relevant ROM in the [checksums/](/checksums/) folder.
		* If the checksums don't match, you'll have to find a ROM that does otherwise you can't expect 100% reliable results if data got misaligned or modified unexpectedly.
8. Open the relevant bootstrap file for your ROM from [templates/](/templates/).
	* If you're using the decompressed Majora's Mask debug ROM for example, you'd use `dMM_E_debug.bt`.
9. Once you have the template open, click `Run Template` [near the file tab](http://i.imgur.com/stHPn56.png).
	* You must have both the template and the ROM open in 010 at the same time to do this.
	* Once you do this once, it you can just hit F5 on either the template or the ROM to re-run them. You can also click the white triangle.
10. After you've run the template, you should see the `Template Results` panel.
	* You can use this to [explore and modify parts of the ROM that have been templated](http://i.imgur.com/i27WJvD.png).
	* This will help you understand where data exists relative to other data.
	* It will also make it easier to spot data that hasn't been identified yet.