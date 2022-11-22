---
title: "Electron, Linux, and Your File Chooser"
date: 2021-04-01T19:29:05-05:00
tags:
  - programming
  - electron
---

Electron has done a lot of good for desktop Linux. Without it, the desktop app
selection would probably be much poorer, but many users have complained about
the file chooser.

<!--more-->

Unfortunately for desktop Linux users, Electron assumes desktop Linux is a
mono-culture. It assumes all of us use GTK, which has been a problem for a long
time. If you have hopped from GTK-based desktop environments to Qt-based desktop
environments, you have probably noticed one of the largest issues is that all
your favorite Electron applications present you with the GTK file chooser
instead of the platform-preferred Qt file chooser.

## The GTK File Chooser

The GTK file chooser since GTK3 came along has been a hot topic of discussion
for many people for various reasons that aren't super important for the purpose
of this blog post. What is important though is that these people who dislike the
GTK file chooser tend to prefer the Qt file chooser.

## The XDG Desktop Portal Specification

Desktop Linux has changed a lot over the past couple of years especially with
the introduction of container formats like Flatpak and Snap. The developments of
these technologies brought about something called the XDG Desktop Portal
Specification. This specification allows containers to talk to the host system
in a standardized way. One such function is displaying the system's file
chooser.

Up to this point, I have only talked about it in the context of container
applications, but the specification also benefits native host binaries as well.
The XDG Desktop Portal Specification is a set of D-Bus APIs for talking to the
host system. Toolkits like GTK and Qt can take advantage of this in order to use
the platform-specific file chooser on Linux. They send out D-Bus messages just
like Flatpak, so what you end up with is applications like Firefox can now show
the Qt file chooser when told to do so.

### Setting Up the XDG Desktop Portal

There are currently three portal implementations.

- `xdg-desktop-portal-gtk`
- `xdg-desktop-portal-kde`
- `xdg-desktop-portal-wlr` (wlroots) - sway users would need this one

One of these has to be installed on your system. It should be fairly obvious
which one you need, and if your distribution isn't installing one of these for
you on the base image, file an issue. Once you have one of these installed, you
will want to export an environment variable called `GTK_USE_PORTAL` and set it
to `1`. Now GTK applications should be able to open the Qt file chooser for
instance. I am not entirely sure if there is an equivalent environment variable
for Qt.

## Electron

Now you are probably asking yourself how this applies to Electron. Electron is
based on Chromium, and Chromium uses GTK on Linux, so naturally Electron does as
well. In GTK there are two classes to make note of:

- [`GtkFileChooserDialog`](https://docs.gtk.org/gtk4/class.FileChooserDialog.html)
- [`GtkFileChooserNative`](https://docs.gtk.org/gtk4/class.FileChooserNative.html)

The native variant will show the Windows or Mac file choosers on those
platforms, but on Linux, the native variant actually speaks to the XDG Desktop
Portal.

`GtkFileChooserNative`[^1] first appeared in the 3.20 series of GTK, and
Electron has to support Ubuntu 16.04 because that is what Chromium supports.
Ubuntu 16.04 only ships GTK 3.18, so all the GTK-related code has to use the
3.18 APIs, which meant Electron used `GtkFileChooserDialog`.

Many platforms include ways to open a shared object at runtime, and pull
functions or other information out. On Linux, this set of APIs is provided by
`libdl`[^2]. So I realized something. Electron only has to **compile** against
GTK 3.18. That doesn't mean we can't do some fancy stuff at runtime.

## Development Process

I typically like to browse the VSCode issue milestones to see what goodies are
coming up in the next release. Two years ago (7/2020), I started my first job,
and I remember I had nothing to do, so I started reading VSCode issues, and saw
an issue regarding VSCode not respecting the Qt file chooser on KDE. I saw one
person had started working on a PR to Electron, but failed because he was trying
to use the GTK 3.20 API, and never followed through on any PR comments. I took a
look at the problem, and started down this runtime-based solution.

I knew Electron was a beast to compile, so at the beginning I didn't even try to
compile Electron on my system. I would just use the Electron CI pipelines to my
advantage. Finally I became too annoyed and got Electron building on my laptop,
but it took the whole night. I finished my initial attempt, and wanted to see if
what I had done actually worked. I booted into a live Fedora KDE system and
wrote up a tiny Electron project to see if what I had done worked. I wasn't
seeing the Qt file chooser like I had expected. I opened up a D-Bus inspector,
and rightfully so, I wasn't seeing the appropriate D-Bus calls across the wire.
Then I realized I wasn't exporting `GTK_USE_PORTAL=1`. At that point, my
solution actually worked, and I was able to post a picture on my
[PR](https://github.com/electron/electron/pull/19159) with the proof that my
work paid off. From there, various improvements were made until finally on April
1st, 2021 the PR was merged into Electron's master branch.

## Technical Solution

Now what most of you are here for.

On the first time an Electron process tries to open a file chooser on Linux, I
open a handle to `libgtk-3.so` that stays open until the process ends. While
still on the first time, I use `GModule` to ask the shared object for functions
relating to `GtkFileChooserNative`. If all the functions are found, I know I am
running against a GTK3 version of `>=`3.20. I cache a boolean that says GTK
supports `GtkFileChooserNative`. What this check at runtime allows me to do is
to support Ubuntu 16.04 in a backwards compatible manner. With the boolean I
stashed away, any place Electron interacted with the GTK file chooser, I
branched, checking "if `GtkFileChooserNative` supported, do this, otherwise
fallback to that". The functions pretty much match 1:1 with
`GtkFileChooserDialog` and `GtkFileChooserNative`, so I didn't have to do a
whole lot. I did have to remove the preview widget when running against
`GtkFileChooserNative` because it isn't supported. I also had to change up the
ways file filters are added because `GtkFileChooserNative` doesn't support
adding custom filters.

At the end of it all, I had my first
[commit](https://github.com/electron/electron/commit/fa65faa4b0221dfd6e5d64abcff01321640a19ad)
to Electron.

## Retrospective on the Electron PR Process

This was my first contribution to Electron ever. Electron is a large project
with lots of major stakeholders. Unfortunately for small people like me, we are
at the whims of major corporations like Microsoft and Salesforce (Slack).
Although Electron supports Linux, I wouldn't necessarily say that there are a
lot of stakeholders who care about it from what I experienced.

Like I said, I started this PR on {{< time 2019-07-08 >}}, and it got merged on
{{< time 2021-04-01 >}}. I was an involved contributor, making sure that any
conflicts were resolved and fixing any feedback when it was provided.

Feedback was sparse and took months before conversation would continue. In
total, I had 7 people review my PR, but I think maybe only 4 or 5 were
associated with the project. At least one person seemed to be a Canonical
employee, but he never followed up after I addressed his feedback. I figured if
ever there was a stakeholder to want to get this merged, it would be Canonical
because of Snap, but sadly I was mistaken.

The first year of the PR went by, and there were quite a few months of silence.
Around November of {{< time 2020 >}}, I finally heard from someone involved in
Electron that inspired confidence that finally this would get over the hump.
Unfortunately that didn't happen.

Another month or two passed with silence, and I heard from one of the
maintainers that my PR would be slated for the 12.0 release of Electron. I was
excited once again. 12.0 released, and my PR was still not merged. I ended up
tagging the maintainer, but he never responded.

In March of this year, I finally got a response from a maintainer by the name of
[Cheng Zhao](https://github.com/zcbenz), who appears to be an employee of
Microsoft and is a top contributor to Electron. He seemed to even be the author
of the initial Linux support for Electron. He and another user named
[Ryan Gonzalez](https://github.com/refi64) provided the last bit of feedback I
needed to get my PR into a good state. Once all the feedback was responded to,
Cheng merged my PR and the rest was history. The PR is slated for a minor
Electron release. I am not sure if it will be backported, but surely the next
12.X release will have my work in it. Eventually it'll land downstream in
projects like VSCode when they upgrade their Electron version.

My biggest complaints about the process were definitely the time scale that it
took place on and the extended periods of silence. I had a 1 year anniversary at
the job I started this on, and I joined a new company all within the time span
of the PR being open. I have an idea of another contribution to Electron, I
would like to make, but it'll take a little bit more research and thought. This
process was difficult, but I will continue to contribute as long as it benefits
myself and other desktop Linux users.

Lastly, users generally don't understand the relationship between projects that
they use and their upstreams. I consistently felt really bad when VSCode
maintainers would get tagged in the PR. The VSCode maintainers have essentially
no control in how code that would benefit their project is merged. The VSCode
maintainers are truly awesome people, and we should do our best to lessen spam
that they get tagged in. This really goes for any software maintainer.

## Appreciation

I would like to thank the following people/groups for helping me with getting
this PR merged over the course of two years.

- Cheng Zhao
- Sriram Ramkrishna
- Ryan Gonzalez
- #gtk

Desktop Linux users everywhere should give credit to the aforementioned because
without them, this PR may not have ever gotten merged.

[^1]:
    If you are using an application that doesn't use `GtkFileChooserNative`, it
    could be worth opening a dialog with the maintainer to better support
    alternative platforms.

[^2]:
    GLib provides an abstraction called `GModule` that abstracts away
    platform-specifics.
