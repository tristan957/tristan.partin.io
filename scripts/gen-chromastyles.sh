#!/bin/sh

# SPDX-License-Identifier: CC0-1.0
# SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>

hugo gen chromastyles --style=onedark >assets/css/syntax-dark.css
hugo gen chromastyles --style=github >assets/css/syntax-light.css
