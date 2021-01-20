#! /bin/bash

if [ "$1" != '' ] && [ -f "$1" ]; then
    t0='0'
    title0=''
    for l in $(sed -n -r 's/([0-9]+) *([0-9]*:?[0-9]+:[0-9]+) *(.*)/\1;\2;\3/p' split | tr ' ' '_'); do
        IFS=';'
        read -raabcd <<< $l
        if [ $t0 != '0' ]; then ffmpeg -i "$1" -codec copy -ss $t0 -to ${abcd[1]} "$title0.mp4"; fi
        t0=${abcd[1]}
        title0="${abcd[0]}_${abcd[2]}"
        IFS=' '
    done

    ffmpeg -i "$1" -codec copy -ss $t0 "$title0.mp4"
else
    echo 'Provide a valid fname as argument!'
fi
