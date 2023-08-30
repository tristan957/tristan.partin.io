#!/bin/sh

# SPDX-License-Identifier: CC0-1.0
#
# SPDX-FileCopyrightText: 2023 Tristan Partin <tristan@partin.io>

# shellcheck disable=SC2046
shellcheck $(find scripts/ -type f -name '*.sh')
