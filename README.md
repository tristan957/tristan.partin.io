<!--
SPDX-License-Identifier: Unlicense

SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>
-->

<!-- prettier-ignore-start -->

<!-- markdownlint-disable-next-line MD041 -->
[![builds.sr.ht status](https://builds.sr.ht/~tristan957/tristan.partin.io.svg)](https://builds.sr.ht/~tristan957/tristan.partin.io?)

<!-- prettier-ignore-end -->

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
- Run the `scripts/openring/build.sh` script from the project root
- Run `hugo -D server` to get live reloading in a development environment

## Miscellaneous

### Marking a blog as unlisted

Add the following to the front-matter

```yaml
_build:
  list: never
```

### Permissions-Policy

Generate a `Permissions-Policy` [here](https://www.permissionspolicy.com/).

## Licenses

The code is licensed under the AGPL-3.0.

The content on the site is licensed under the CC-BY-SA-4.0.
