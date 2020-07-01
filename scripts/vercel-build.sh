#!/usr/bin/env sh

export HUGO_BASEURL=$VERCEL_URL
echo "baseURL = $HUGO_BASEURL"
hugo
