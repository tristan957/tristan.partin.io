---
title: "iCloud and CalDAV"
date: 2026-10-03T10:29:36-05:00
draft: true
toc: false
---

Recently I've become quite a calendar afficianado. However, I ran into a problem
with iCloud and CalDAV that I would like to share.

<!--more-->

I manage my email, contacts, and calendars with [Fastmail] using a custom domain
that I own.

[Fastmail]: https://www.fastmail.com/

I owned an iPod Touch many year ago, and because of that, I created an Apple
account. These days I primarily use the account to watch Apple TV. My username
on my account is (_was_) my regular everyday email.

My fianceé is an iPhone and MacBook user, so naturally she has an Apple account.
Her primary calendaring application is Apple Calendar, which by default uses the
calendars backed by iCloud.

She and I have have been working on sharing our calendars in a more streamlined
way by subscribing to each other's calendars and inviting the other when
appropriate, so it is easy to understand who is doing what when.

The problem seems to be when my fianceé invites me to an event. Normally, when
you receive an invitation to an event, you get an email asking you to RSVP. That
wasn't the case when she would invite me to events that were placed on her
iCloud calendar. Invitations seemed to go to the void. One day, I logged into
[icloud.com], and navigated to the Calendar application, and lo and behold there
was a list of invitations from my fianceé. Luckily, most people don't use iCloud
for their email and calendaring needs, so there weren't more than a handful of
invitations.

[icloud.com]: https://www.icloud.com/

My only conclustion of this experience is that iCloud intercepts calendar
invites for whatever reason and checks whether the recipient has an Apple
account. If so, the invitation never reaches their email inbox, and instead is
sent directly to Apple Calendar, even if you don't use Apple Calendar. This
behavior is really annoying, and I left feedback for Apple about it, but in
classic big company fashion, I am sure that they will never get back to me.

In the end, the only solution seemed to be changing my Apple account email from
`me@example.com` to `me+apple@example.com`.
