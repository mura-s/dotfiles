#!/bin/bash

cd "$(dirname $0)"
extension_file="$(pwd)/extensions"

code --list-extensions > $extension_file
