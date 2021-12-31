#!/bin/sh

cd hugo || exit
CGO_ENABLED=1 go build --tags extended -o ../bin/hugo
