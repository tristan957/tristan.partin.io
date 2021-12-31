[![builds.sr.ht status](https://builds.sr.ht/~tristan957/tristan.partin.io.svg)](https://builds.sr.ht/~tristan957/tristan.partin.io?)

# tristan.partin.io

This is code used to create [tristan.partin.io](https://tristan.partin.io).

## Comments

Comments can be emailed to my
[public inbox](mailto:tristan957/public-inbox@lists.sr.ht).

## Theme

The site also includes dark mode support which will be handled by your system
preferences, specifically `prefers-color-scheme`.

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

### Permissions-Policy

https://www.permissionspolicy.com/ generates a valid `Permissions-Policy` value.

## Licenses

The code is licensed under the AGPL-3.0.

The content on the site is licensed under the CC-BY-SA-4.0.
