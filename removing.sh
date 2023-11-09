#!/bin/bash

check="$(ls /home/ansar/backup/ | wc -l)" 

if [[ $check>=3 ]] ;
then
        rm "$(ls -t | tail -n 1)"
fi

