# notes for 

# wareya on original dumps
## ZELOOTMA.z64
* ROM HASH: 8CA71E87DE4CE5E9F6EC916202A623E9 (OOT)
* The OOT Debug ROM is a perfect dump.
* It might have been watermarked, and if it was, the watermark has been removed.
* It's a european-language copy of the game, but it's compiled with NTSC rates, due to being targeted at GC N64 emulation (Master Quest).

## MMDBG.z64
* ROM HASH: 71FBAE5D2B27926EA54E92CE2FC91622 (MM)
* The MM Debug ROM is a perfect dump.
* However, it's a full PAL N64 ROM.
* That said, it doesn't have region protection enabled. 
* Also, some "useless buffer data", which was full of FFFF bytes, was overwritten with release notes.
* This is not part of the ROM data, so it's fine.

# About Cutscenes
(5:43:02 PM) mzxrules: the value of the scene setup number is determined by a bunch of things
(5:43:39 PM) mzxrules: the general rule of thumb is that values 0-3 are for child day/night, adult day/night, then 4+ are used for cutscenes 0-C

# Yaz0 Blocks Still In The Decompressed One

## About The Yaz0s
(3:58:13 PM) DerrikeG: CloudMax: at 0x00A4C00C in the decompressed MM debug ROM there's the string "Yaz0", does that mean that it's a block that's still compressed?
(3:58:35 PM) DerrikeG: this is inside the file  beginning at 00A09E70
(3:58:42 PM) CloudMax: If I recall correctly, even the decompressed ROM still have yaz0 blocks in it that are decompressed on runtime
(3:59:24 PM) DerrikeG: so if I want whatever is in there, I need to decompress it on the side

## Counts
* As many as 928 instances.
* Starts as early as 0x009C30EC (file 009C2000)
* Last instance as late as 0x00A65794 (file 00A65A10)