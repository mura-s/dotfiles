#!/bin/bash

extension_file="./extensions"

cat $extension_file | while read line
do
  code --install-extension $line
done
