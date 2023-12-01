#!/bin/bash
set -x
rm -rf out
mkdir -p out/release && cd out/release
cmake ../..
make
