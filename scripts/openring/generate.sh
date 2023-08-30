#!/bin/sh

# SPDX-License-Identifier: CC0-1.0
# SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>

./bin/openring \
	-S webring.txt \
	<include/webring-in.html \
	>layouts/partials/webring-out.html
