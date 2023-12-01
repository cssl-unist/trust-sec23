#!/bin/bash
set -x
rm -rf build
mkdir build && cd build
cmake ..
make
