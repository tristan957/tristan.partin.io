---
title: "Introduction to my Dotfiles"
date: 2024-07-24T00:07:44-05:00
series: dotfiles
---

Over time, I've accrued a fair amount of dotfiles. I thought I would share an
overview of them through a series of blog posts, starting now!

<!--more-->

## Background

Dotfiles is a term that represents your user's configuration. In an ideal
scenario, you can copy them between machines and easily have the same setup.
Many times these configuration files can be found underneath
`${XDG_CONFIG_HOME:-$HOME/.config}`[^1].

## History

I started tracking my dotfiles in college, specifically
{{< time "December 29th, 2017" >}}. I worked on them off and on during the
school years to procastinate on studying and doing homework[^2]. My dotfiles are
primarily stored on [SourceHut], but were originally stored on [GitHub], where I
keep a mirror to this day.

[SourceHut]: https://git.sr.ht/~tristan957/dotfiles
[GitHub]: https://github.com/tristan957/dotfiles

## Structure

I use [GNU Stow] to manage my dotfiles. It is packaged on the systems I care about,
semi-maintained, not some cobbled together symlink kludge of my own doing. I learned
about stow early on in my dotfiles history, and my original commit made use of it.

[GNU Stow]: https://www.gnu.org/software/stow/stow.html

Stow organizes content into packages, so a `bash` package would typically
contain any information related to [`bash`]. My original commit contained 4
packages. At the time of writing, I have 51 packages, which are all listed in
the repository's README. It's a fairly large repository these days, with over
1300 commits. My largest package is definitely my [Neovim] configuration. If
it's a tool that I use, and it has a configuration, whether that be via
environment variables or a file, I have it stowed in my dotfiles.

[`bash`]: https://www.gnu.org/software/bash/
[Neovim]: https://neovim.io

## Licensing

My dotfiles are licensed under the [CC0-1.0], meaning they exist in the public
domain. Please steal them as you wish!

[CC0-1.0]: https://creativecommons.org/publicdomain/zero/1.0/

## Conclusion

This was just a general overview of my dotfiles. I hope to break it down into
more details over the next series of posts.

[^1]:
    Refer to the
    [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
    for more details.

[^2]: I still work on them for the same reasons to this day!
