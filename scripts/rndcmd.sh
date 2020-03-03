#!/bin/bash
wordList1=($1)
wordList2=($2)
for w in $(seq 0 ${#wordList2}) ; do
echo -n "${wordList2[$w]:0:$(($RANDOM % (${#wordList2[$w]} - (${#wordList1[$w]} - 1)) + ${#wordList1[$w]}))} "
done
exit 0
