#!/bin/bash

cut -d\  -f1 < $1 | sort > nodes.txt
egrep -- '->' $1 | cut -d\  -f4- | sed -e 's/, /\n/g' | sort > children.txt
comm -3 nodes.txt children.txt
