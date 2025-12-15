#!/bin/bash

if [[ "$#" -ne 5 ]]; then
  echo "Usage: <Hex Address - Hex Digits Only> <tag> <index> <offset> <associativity>" 1>&2
  exit 1
fi

hexaddress=$1 tag_bits=$2 index_bits=$3 offset_bits=$4 associativity=$5

if ! let hexaddress=16#${hexaddress#0[Xx]}; then
  echo "ERROR: bad hex value passed: '$hexaddress'" 1>&2
  exit 1
fi

# credits to my professor for assisting with lines 10 - 13 && 17 - 19
(( tag = hexaddress >> (index_bits + offset_bits) ))
(( index = (hexaddress >> offset_bits) & (2 ** index_bits - 1) ))
(( offset = hexaddress & (2 ** offset_bits - 1) ))

(( num_sets = (2 ** index_bits) ))
(( block_size = (2 ** offset_bits) ))
(( cache_size = (num_sets * block_size * associativity) ))
(( cache_lines = num_sets * associativity ))

echo "Binary Address: `echo "obase=2; $hexaddress" | bc`"
printf "Tag: 0x%x\n" $tag
printf "Offset: 0x%x\n" $offset
printf "Index: 0x%x\n" $index
printf "Number of rows/sets: %d\n" $num_sets
printf "Block Size: %d bytes/blocks\n" $block_size
printf "Cache Size: %d bytes\n" $cache_size
printf "Total Cache Lines: %d\n" $cache_lines
