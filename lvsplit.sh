#! /bin/bash

# number time title:
#REX='s/([0-9]+) *([0-9]*:?[0-9]+:[0-9]+) *(.*)/\1;\2;\3/p'
# time title:
REX='s/([0-9]*:?[0-9]+:[0-9]+) *(.*)/_;\1;\2/p'

#EXT='.mp4'
EXT='.webm'

if [ "$1" != '' ] && [ -f "$1" ]; then
    t0='0'
    title0=''
    for l in $(sed -n -r "$REX" split | tr ' ' '_'); do
        IFS=';'
        read -raabcd <<< $l
        if [ $t0 != '0' ]; then ffmpeg -i "$1" -codec copy -ss $t0 -to ${abcd[1]} "$title0$EXT"; fi
        t0=${abcd[1]}
        if [ "${abcd[0]}" != '_' ]; then title0="${abcd[0]}_${abcd[2]}"; else title0="${abcd[2]}"; fi
        IFS=' '
    done

    ffmpeg -i "$1" -codec copy -ss $t0 "$title0$EXT"
else
    echo 'Provide a valid fname as argument!'
fi
