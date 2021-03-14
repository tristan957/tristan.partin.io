#!/usr/bin/env sh

./openring/openring \
	-S webring.txt \
	< include/webring-in.html \
	> layouts/partials/webring-out.html
