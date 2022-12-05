#!/bin/sh

# SPDX-License-Identifier: Unlicense
# SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>

./bin/openring \
    -S webring.txt \
    < include/webring-in.html \
    > layouts/partials/webring-out.html
