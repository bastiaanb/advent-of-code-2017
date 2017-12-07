#!/bin/bash

egrep -o '[a-z]+' | sort | uniq -u
