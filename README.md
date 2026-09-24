<!--
SPDX-License-Identifier: CC0-1.0

SPDX-FileCopyrightText: Tristan Partin <tristan@partin.io>
-->

<!-- prettier-ignore-start -->

<!-- markdownlint-disable-next-line MD041 -->
[![builds.sr.ht status](https://builds.sr.ht/~tristan957/tristan.partin.io.svg)](https://builds.sr.ht/~tristan957/tristan.partin.io?)

<!-- prettier-ignore-end -->

# tristan.partin.io

This is code used to create [tristan.partin.io](https://tristan.partin.io).

## Comments

Comments can be emailed to my [public inbox].

[public inbox]: mailto:tristan957/public-inbox@lists.sr.ht

## Theme

The site also includes dark mode support which will be handled by your system
preferences, specifically `prefers-color-scheme`.

It is inspired by an older iteration of [drewdevault.com].

[drewdevault.com]: https://drewdevault.com

## Contributing

- Clone the repo
- Run `devenv shell` to get `hugo` and the other project tools
- Run `devenv up` to start the Hugo development server with live reloading
- Make any changes

## Miscellaneous

### Marking a Blog as Unlisted

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
