#!/bin/bash

version=$1

go get golang.org/dl/go${version}
go${version} download
rm $GOPATH/bin/go
ln -s $GOPATH/bin/go${version} $GOPATH/bin/go
