#!/usr/bin/env sh

./bin/openring \
	-S webring.txt \
	< include/webring-in.html \
	> layouts/partials/webring-out.html
