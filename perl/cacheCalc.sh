#!/bin/bash

if [[ $# -lt 5 ]]; then
  echo "Format: <hex address> <tag-bits> <index-bits> <offset-bits> <associativity>"
  exit
fi
 
hexaddr=$1
tag_bits=$2
index_bits=$3
offset_bits=$4
associativity=$5
 
read -r -d '' perlscript <<'EOF'
  my ($hex, $tag_bits, $index_bits, $offset_bits, $associativity) = @ARGV;

  my $addr = hex($hex);
 
  # converts hex to binary address
  my $binaddr = sprintf('%b',$addr);
  printf("binaddr = %s\n", $binaddr);

  my $tag = ($addr >> ($index_bits + $offset_bits));
  my $index = ($addr >> $offset_bits) & (2 ** $index_bits - 1);
  my $offset = $addr & (2 ** $offset_bits - 1);
 
  my $numsets = (2 ** $index_bits);
  my $blocksize = (2 ** $offset_bits);
  my $cachesize = ($numsets * $blocksize * $associativity);
  my $cachelines = ($numsets * $associativity);
 
  printf("tag = 0x%x\n", $tag);
  printf("index = 0x%x\n", $index);
  printf("offset = 0x%x\n", $offset);
 
  printf("sets = %d\n", $numsets);
  printf("cache size = %d\n", $cachesize);
  printf("total cache lines = %d\n", $cachelines);
   
  #printf("tag = 0x%0*x\n", ($tag_bits % 4 == 0 ? ($tag_bits / 4) : int(($tag_bits + 4) / 4)), $tag);
  #printf("index = 0x%0*x\n", ($index_bits % 4 == 0 ? ($index_bits / 4) : ($index_bits + 4) / 4), $index);
  #printf("offset = 0x%0*x\n", ($offset_bits % 4 == 0 ? ($offset_bits / 4) : ($offset_bits + 4) / 4), $offset);
 
  my $nlen = length($hex) * 4;
  $binaddr = sprintf('%0*s', nlen, $binaddr);
EOF
 
perl -e "$perlscript" "$hexaddr" "$tag_bits" "$index_bits" "$offset_bits" "$associativity"
