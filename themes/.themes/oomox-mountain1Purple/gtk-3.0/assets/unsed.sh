#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#ded5ee/g' \
         -e 's/rgb(100%,100%,100%)/#000000/g' \
    -e 's/rgb(50%,0%,0%)/#000000/g' \
     -e 's/rgb(0%,50%,0%)/#5259c0/g' \
 -e 's/rgb(0%,50.196078%,0%)/#5259c0/g' \
     -e 's/rgb(50%,0%,50%)/#fffdff/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#fffdff/g' \
     -e 's/rgb(0%,0%,50%)/#000000/g' \
	"$@"
