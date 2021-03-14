---
title: "The Worst Performing Website I Have Ever Found"
date: 2021-03-13T19:30:30-06:00
tags:
  - webdev
---

Today I was reminded of a time that I found the worst website ever in terms of
its performance.

<!--more-->

About a year and a half ago at this point, I was contacted by a recuiter on
LinkedIn for becoming a C++ engineer at this company[^1]. I went to their
website to read more about the company, and boy was I in for a surprise.

The website I landed on was a monstrosity. I had seen splash screens on websites
before, but those were for heavy web applications, which can be understandable.
In this case however, the splash screen was for the home page of the company. I
think I sat waiting at the splash screen for about 15 seconds. Finally the page
loaded. There was nothing special about the site. Just your run-of-the-mill
homepage with generic information. I decided I had to investigate the
performance of the website.

I disabled my cache and went to inspect the network requests on page load and
what I found was even more alarming. There were ~50 requests over the wire
fetching data which didn't fully complete for 30 seconds, but worst of all 13 MB
had been downloaded to my machine just to display the site. For reference, this
site has 8 network requests with just under 200 KB transferred, and obviously it
loads almost instantly.

We live in a time where website performance is extremely important to the
success of a website. User engagement studies say that many users will skip
going to your site if it takes longer than 3 seconds to load. Site performance
is also a key characteristic in helping your websites reach the top of search
engine resutls.

I urge everyone reading this to brush up on their profiling skills and find
tools which can help diagnose issues on your site. For me, that tool is Google's
lighthouse, but there are many tools like it.

Let me know about any website performance stories you might have, good or bad.

[^1]: Not providing the name out of respect.
