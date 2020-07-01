#!/usr/bin/env sh

./openring/openring \
	-s https://drewdevault.com/feed.xml \
	-s https://emersion.fr/blog/rss.xml \
	-s https://blog.golang.org/feed.atom \
	-s https://blog.rust-lang.org/feed.xml \
	-s https://blog.mozilla.org/feed/ \
	< include/webring-in.html \
	> layouts/partials/webring-out.html
