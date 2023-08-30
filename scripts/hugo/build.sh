#!/bin/sh

# SPDX-License-Identifier: CC0-1.0
# SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>

cd hugo || exit
CGO_ENABLED=1 go build --tags extended -o ../bin/hugo -x -v
