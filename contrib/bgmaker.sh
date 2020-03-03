#!/bin/bash

if [ $# -ne 1] ; then
echo "usage $0 filename"
fi
#process the file for tintin's background music format.
#remove silence from both ends of file, and reduce the volume by quite a bit.
#usually -10 is enough, but may need to be adjusted.
#The final product will be named tmp.ogg
sox "$1" -r 22050 tmp.ogg silence 1 0.1 1% reverse silence 1 0.1 1% reverse norm -10
exit 0
