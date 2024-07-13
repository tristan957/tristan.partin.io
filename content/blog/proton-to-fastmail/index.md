---
title: "Proton to Fastmail"
date: 2024-05-17T00:56:07-05:00
toc: false
tags:
  - proton
  - fastmail
---

I moved from [Proton](https://proton.me) to [Fastmail](https://fastmail.com)!

<!--more-->

My email history began with an `swbell.net` account, created by my dad. It was
and probably still is managed by Yahoo, but whether or not I still have access
is up in the air. Then, as Android began to take off, I got a Google account,
which came with a Gmail account. I used that Gmail account as my primary account
for a long time, and I still use it for certain functions to this day. In
college, I met my buddy Joseph who had a `firstname@lastname.tld` email. At the
same time, I was learning about how useful it is to have your own domain for
email because you can move providers without changing your email. These factors
led me to buy `partin.io`.

Now that I had a domain, I needed an email provider. I am very much into privacy
and had learned about Proton, and that was what I went with, which I used for
about five years, that is until last week, when I moved to Fastmail.

Proton is an extremely privacy focused provider. They have encryption for all
their services. I liked this aspect because I didn't want my data to be read by
governments or to potentially be leaked via a hack. For a while, this setup
worked pretty well.

Then back in May of {{< time 2023 >}}, I joined [Neon](https://neon.tech) to
work on [PostgreSQL](https://postgresql.org). PostgreSQL is an old project that
dates back to the 1980s. It still uses mailing lists for development (which has
pros and cons). When email first started out, the primary
[MIME type](https://developer.mozilla.org/en-US/docs/Glossary/MIME_type) for
email was `text/plain`. But since the start of the century, `text/html` has
become the dominant MIME type for email. Nevertheless, mailing lists primarily
deal in plaintext email. Plaintext email has a couple of
[paradigms](https://useplaintext.email#etiquette) that people tend to adhere to.
Proton's web client, while being pretty good, is not great for plaintext email.
So I searched and tried desktop email clients and eventually landed on
[aerc](https://aerc-mail.org), which is a terminal-based email client.

At this point, let's explore "modern" email protocols:
[Internet Message Access Protocol](https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol)
(IMAP) and
[Simple Mail Transfer Protocol](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol)
(SMTP). IMAP is used for accessing mailboxes, and SMTP is used for sending
emails. Email was created in {{< time 1971 >}} and very much deals in plaintext,
similar to HTTP. This presents an issue for Proton. Because Proton encrypts its
data, it can't use regular email protocols easily. Proton recognizes the value
in continuing to support IMAP and SMTP, so they created a
[Bridge](https://proton.me/mail/bridge). It creates IMAP and SMTP servers that
run on `localhost`, which you can connect to with any regular desktop email
client. The SMTP server works fine. The IMAP server however leaves a lot on the
table. This is where we get into some more details about IMAP. It was created in
{{< time 1986 >}}. As you can imagine, a lot of things can change in four
decades, so follow-on RFCs have been produced to extend the protocol. Some IMAP
servers are pretty basic. Others have many more features. Unfortunately,
Proton's IMAP server is pretty barebones. This leads to my experience in aerc
being much less than stellar.

Given these deficiencies, I persevered, continuing to use Proton's clients for
most emails, and aerc when I needed to interact with a mailing list. Neon is
also a fairly relaxed company, and I was given the opportunity to use my
personal email for PostgreSQL development, but I couldn't, at least not easily,
given the above, so I stuck with my Neon Google Workspace email for development.

After continuing to use aerc, I just fell in love with it. I seriously think it
is one of the best email clients in existence, so I wanted to use it for my
personal email and not just my work email. 1 year of aerc usage and frustration
with the Proton Bridge and their lack of standardized protocols was my breaking
point.

Enter Fastmail! Fastmail is a great service. They have people working there that
actively work on standardized protocols like IMAP and
[JMAP](https://jmap.io)[^1] (JSON Meta Application Protocol). JMAP is a new
protocol meant for accessing mailboxes and sending emails. aerc happens to
include support for JMAP out of the box because a few of the core developers use
it[^2]. Other benefits of Fastmail are access to
[WebDAV](https://en.wikipedia.org/wiki/WebDAV),
[CardDAV](https://en.wikipedia.org/wiki/CardDAV), and
[CalDAV](https://en.wikipedia.org/wiki/CalDAV). These protocols mean support for
[GNOME Files](https://apps.gnome.org/Nautilus/),
[GNOME Contacts](https://apps.gnome.org/Contacts/), and
[GNOME Calendar](https://apps.gnome.org/Calendar/). On my phone, I've downloaded
an app called [DAVx5](https://www.davx5.com/), which allows me to integrate
calendars and contacts into Android's apps. Standardized protocols are amazing
because they allow apps and services to interoperate. That has easily been the
greatest part of moving to Fastmail.

{{< aside >}}

<!-- prettier-ignore-start -->

<!-- markdownlint-disable-next-line MD034 -->
If you're on the PostgreSQL mailing lists, you'll see me as tristan@partin.io in
the future.

<!-- prettier-ignore-end -->

{{< /aside >}}

This blog is not meant to diminish Proton in any way. Proton is a great service
and would probably serve most people well, but my workflows just weren't a
priority for them, and that's ok. It just means that it was my time to leave.

Here's to the continued success of both Proton and Fastmail, as well as the
continued development of aerc and JMAP[^3]!

[^1]: Eventually JMAP will get support for contacts and calendars too.

[^2]: I must admit these guys had a huge effect on me switching to Fastmail.

[^3]:
    Also, shoutout to the people that make great apps to consume these
    standardized protocols.
