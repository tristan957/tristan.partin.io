[![builds.sr.ht status](https://builds.sr.ht/~tristan957/tristan.partin.io.svg)](https://builds.sr.ht/~tristan957/tristan.partin.io?)

# tristan.partin.io

This is code used to create the [tristan.partin.io](https://tristan.partin.io).

## Comments

The site itself will function without JavaScript enabled. It has the ability to
show comments on the page using [utteranc.es](https://utteranc.es), but
otherwise comments can be emailed to my
[public inbox](mailto:tristan957/public-inbox@lists.sr.ht).

## Theme

The site also includes dark mode support which will be handled by your system
preferences. Alternatively, there is a toggle if you prefer one theme over the
other. The option is stored in local storage as `site-theme`. Note the toggle
requires JavaScript to be enabled.

It is inspired by [drewdevault.com](https://drewdevault.com).

## Dependencies

- [`hugo`](https://gohugo.io) `>= 0.65`
- [`openring`](https://git.sr.ht/~sircmpwn/openring)

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

## Licenses

The code is licensed under the GPL-3.0.

The content on the site is licensed under the CC-BY-SA-4.0.
