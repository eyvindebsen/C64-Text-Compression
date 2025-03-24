Text compression, using a huge REL lookup table for the Commodore 64. (c64 basic v2)

The challenge is to compress as much as possible of
the King James version of the bible on 1 disk. (1541-II 160kb, or 1581 800kb)
Here is a 160kb disk containing a portion of the text. Will take a while to decompress and look up. The 800kb version contains several books on the same disk.

This is not a religious thing, just a free text online, since there 
are many quirks one can use to compress it. Link below.

This is the BASIC version proving the concept.
All words are scanned from the original text, with spelling errors and ; : errors.
Using external custom made programs.
The text is then compressed at a bitlevel to look up a wordbank, spanning
the length of 2-16 letters long. This word is read from a REL file.
The encoded text is stored in a SEQ file for now. Reading one byte at a time.
Seems to be slow, but the 1541-II drive will cache data for you. (it seems)
Its not possible to have more than 1 REL file open at a time.
But its allowed to have a SEQ file open at the same time with a REL file.
So the entire vocabulary is looked up in the rel-file at runtime.

Words are then cached in memory (127 for now), and bubble sorted one pass, once in a while.
This should speed up the cache. 

Its quite reader friendly for now, since its quite slow 🙂
I wonder if this would work on real hardware. 
If it does, maybe its not a good idea to run it for
a long time, since it would keep the drive spinning forever 😉
This was tested on Vice emulator (GTK)

You can download the raw text of King James bible here:
https://www.gutenberg.org/ebooks/10
