#!/bin/sh

# SPDX-License-Identifier: CC0-1.0
# SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>

hugo gen chromastyles --style=monokai >assets/css/syntax-dark.css
hugo gen chromastyles --style=pygments >assets/css/syntax-light.css
