#! /usr/bin/env bash

# This README file demonstrate the command to determine the bounding box of
# a postscript file. This file can be executed to perform the appropiate task.

gs -dNOPAUSE -dBATCH -sDEVICE=bbox $1
