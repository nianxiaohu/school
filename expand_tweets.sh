#!/bin/bash

printf "Expanding the 2000 tweets ... "

# 'while' loops are similar to 'for loops' in syntax. Here the loop conditional
# is evaluated first, and if it returns 0 then the body of the loop is executed
# and the loop conditional is evaluated again for another iteration.

# the 'read -r' command is used to read a single line from standard input and
# store it in the variable whose name follows it (in this case the variable name
# is tweet)

# the setup of this loop is unusual because the loop conditional operates only
# on input from standard input stream (STDIN)

i=1
cat tweets.txt | while read -r tweet
do
   echo $tweet > tweet_$i.txt
   i=$(( $i + 1 ))
   # To do arithmetic in bash use $(( math )) or alternatively use the 'expr'
   # command. Read more about it by running `man expr`
done

echo done
