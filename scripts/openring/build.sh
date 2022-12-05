#!/bin/sh

# SPDX-License-Identifier: Unlicense
# SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>

cd openring || exit
go build -o ../bin/openring
