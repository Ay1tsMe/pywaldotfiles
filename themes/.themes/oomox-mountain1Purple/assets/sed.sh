#!/bin/sh
sed -i \
         -e 's/#ded5ee/rgb(0%,0%,0%)/g' \
         -e 's/#000000/rgb(100%,100%,100%)/g' \
    -e 's/#000000/rgb(50%,0%,0%)/g' \
     -e 's/#5259c0/rgb(0%,50%,0%)/g' \
     -e 's/#fffdff/rgb(50%,0%,50%)/g' \
     -e 's/#000000/rgb(0%,0%,50%)/g' \
	"$@"
