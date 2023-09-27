#!/bin/bash

if [ -d ./ ]; then
  cd ./
  
  if [ -n "$(find . -maxdepth 1 -type f -name '*.pb')" ]; then
    cp $(find . -maxdepth 1 -type f -name '*.pb' | head -n 1) graph.pb
  else
    echo "No .pb files found"
  fi
fi


cp ./graph.pb ../test/NEB
cp ./graph.pb ../test/strain/script
cp ./graph.pb ../test/nucleation/script
cp ./graph.pb ../test/Mobility/script

echo "All model files have been replaced."
