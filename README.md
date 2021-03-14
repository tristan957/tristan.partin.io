[![builds.sr.ht status](https://builds.sr.ht/~tristan957/tristan.partin.io.svg)](https://builds.sr.ht/~tristan957/tristan.partin.io?)

# tristan.partin.io

This is code used to create the [tristan.partin.io](https://tristan.partin.io).

## Comments

The site itself will function without JavaScript enabled. It has the ability to
show comments on the page using [utteranc.es](https://utteranc.es), otherwise
comments can be emailed to my
[public inbox](mailto:tristan957/public-inbox@lists.sr.ht).

## Theme

The site also includes dark mode support which will be handled by your system
preferences, specifically `prefers-color-scheme`. Alternatively, there is a
toggle if you prefer one theme over the other. The option is stored in local
storage as `site-theme`. Note: the toggle requires JavaScript to be enabled.

It is inspired by an older iteration of
[drewdevault.com](https://drewdevault.com).

## Dependencies

- [`hugo`](https://gohugo.io)
- [`openring`](https://git.sr.ht/~sircmpwn/openring)
- [`prettier`](https://prettier.io/)

## Contributing

- Clone the repo
- Run `git submodule update --init`
- Run the `bootstrap.sh` script from the project root
- Run the `openring/build.sh` script from thie project root
- Run `hugo -D server` to get live reloading in a developement environment

## Miscellaneous

### Marking a blog as unlisted

Add the following to the front-matter

```yaml
_build:
  list: never
```

### Using Fontello

Take the [`config.json`](./assets/fonts/fontello/config.json) to
https://fontello.com/, and make any necessary changes. Download the new font.
Extract the archive into `assets/fonts/` and rename to `fontello`. Move the
`fonts/` directory into `static/fonts/fontello/`.

Make sure the `@font-face` in
[`fontello.css`](./assets/fonts/fontello/css/fontello.css) has
`font-display: swap`.

## Licenses

The code is licensed under the AGPL-3.0.

The content on the site is licensed under the CC-BY-SA-4.0.

See [`fontello`](https://fontello.com/)
[license](./assets/fonts/fontello/LICENSE.txt).
