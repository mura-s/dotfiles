#!/bin/bash

cd "$(dirname $0)"
extension_file="$(pwd)/extensions"

cat $extension_file | while read line
do
  code --install-extension $line
done
