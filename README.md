+---- HexToBin.sh ----+

Example Input & Output:

  ./HexToBin.sh 0xC1F8B9E 12 12 4 
  Usage: <Hex Address - Hex Digits Only> <tag> <index> <offset> <associativity>
  ./HexToBin.sh 0xC1F8B93 12 12 4 2
  Binary Address: 1100000111111000101110011110
  Tag: 0xc1f
  Offset: 0xe
  Index: 0x8b9
  Number of rows/sets: 4096
  Block Size: 16 bytes/block
  Cache Size: 131072 bytes
  Total Cache Lines: 8192
  
------------------

Inspired by the Exam 1 questions in Comp Arch. Calculates the overall structure of a cache given a hex address, the tag, index, and offset bits, and the associativity.
