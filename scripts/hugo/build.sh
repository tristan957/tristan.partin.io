#!/usr/bin/env sh

cd hugo
CGO_ENABLED=1 go build --tags extended -o ../bin/hugo
