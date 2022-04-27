#!/bin/sh

hugo gen chromastyles --style=monokai > assets/css/syntax-dark.css
hugo gen chromastyles --style=pygments > assets/css/syntax-light.css
