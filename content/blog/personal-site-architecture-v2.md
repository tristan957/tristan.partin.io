---
title: "Personal Site Architecture V2"
date: 2020-07-07T00:45:08-05:00
series:
  - meta
tags:
  - devops
  - webdev
  - vercel
  - aws
---

Recently I changed up the architectural backing of this site.

<!--more-->

## Site Background

In the olden days of college, I met a young fellow named
{{< link "https://www.linkedin.com/in/joseph-martinsen/" "Joseph Martinsen" >}}.
He had[^1] this awesome personal website that I really liked. From then on, I
knew that I also wanted a personal website. Joseph's site was essentially a web
version of his resume laid out all nicely with a bit of expansion on certain
points. I had many iterations of designs, starting one day, and moving onto
other endeavors the next day, but used the content on his site to guide my own.
Rinse and repeat. Eventually I became an old man during junior and senior years,
and there were much more pressing issues like what bar I was going to
procrastinate at when my Advanced Operating Systems homework was due at midnight
the next night.

At some point however, I did finally get what one would call an extreme alpha
level site. It had a design with content that I was going to expand on, but
never did _to no one's surprise_. At some point in November of 2018, I purchased
the domain `partin.io` through Route 53. I hosted my personal site on
`tristan.partin.io`.

## Original Architecture

A lot of cloud providers have what they call free tiers. Free tiers enable you
to use small amounts of resources for free generally for a whole year. The cloud
provider I decided to go with was Amazon Web Services. My domain was purchased
through Route 53, so it made sense to make use of AWS' free tier and get myself
a `t2.micro`. I put my alpha site behind NGINX, and off I went with SSL certs
and `www`/`http` redirects to an `https` site. This was my first time managing a
site, but still my site was not ready for prime time. The site basically sat
like this for 2 years.

Earlier this year, I finally got my butt in gear since COVID put us all in a
state of monotony. I finally realized that the content I wanted on my site was
not a rehash of my resume in a prettier format, but instead a site for content
like blogs and random thoughts[^2]. From there I set out to find a good
technology to build the site in. I knew I wanted to have nothing to do with
JavaScript since JavaScript is all the rage. I had to be **counter culture**.
With that in mind, I searched for various static site generators, and wound up
picking Hugo. I knew it was fairly popular, so why not try to use it.

With the technology picked out, I finally got a real site going and hosted on my
server over the course of a weekend. Set my mind to it, and got it done 2.5
years later[^3]. This is how my site sat for the last 3 months.

A Hugo powered site sitting behind an NGINX server, on a `t2.micro` which
`tristan.partin.io` pointed to.

## New Architecture

Same Joseph as before has recently been looking into this company called
{{< link "https://vercel.com/home" "Vercel" >}}. They excel in static and JAM
stack deployments, CDNs, and serverless functions. For the past 3 months while
Joseph was building his wedding site, he has been continually telling me about
the ease of Vercel for deploying his site, and the deployment was free since he
had a "hobby" account. I still wonder how much they pay him to advertise.

I had tried Vercel about a month ago, but was displeased with their Hugo
support. I needed Hugo features they simply didn't support at the time. I even
tried to reach out to their support team to try to get my concerns resolved, and
very recently they actually were.

So with this new ability to deploy into Vercel, I basically spent the last few
days testing it out, and fixing some issues with my site that arose during the
deployment process. I decided that I liked their service enough to drop my
original architecture for it. I got some restrictions on my domain fixed through
Route 53 with the help of AWS support, and transferred the domain into Vercel.
With the domain finally in Vercel, the new architecture was complete. My entire
site and its domain were being managed by Vercel.

Recently in open source circles, I had heard been hearing about this service
called {{< link "https://plausible.io" "Plausible Analytics" >}}. I have a deep
disdain for being tracked on the internet by the likes of internet giants, so I
never had Google Analytics on my site or frankly any analytics. I figured with
the money I was saving no longer paying for an EC2 and Route 53, I would
evaluate Plausible's free trial and see what I thought of it. With that goal in
mind, I setup my trial account to today for free, and am going to see what types
of things I can learn about my miniscule amount of readers, and see if it is
worth the couple dollars a month for the hosted variant. The service itself is
open source, and the code is hosted on GitHub which immediately caught my
attention. Plausible also isn't an advertising company, so the small amount of
data they collect stays with them. For people browsing my site, Plausible will
collect data like the number of concurrent users, recently visited pages,
countries of origin, and number of visits a month. Plausible also has a feature
where you can open up your analytics page for the world to see. I didn't see a
way to do this in the free trial, but rest assured, I will be opening my
analytics page up for the public to see, so that way you all can see the exact
same data that I see. You'll hopefully see that it isn't much, and that the data
is extremely anonymous compared to competitors.

## Conclusion

To summarize it all up, I took 2.5 years to get a working site create with Hugo
sitting behind an NGINX server on a `t2.micro` with a site managed in Route 53.
In the past few days, I moved my same Hugo site to Vercel using their CDN with
my domain and added in an open source analytics engine called Plausible
Analytics.

**Total monthly costs**: ~\$12 to ~\$4[^4]. I no longer pay for an EC2, and my
domain no longer has monthly charges through Route 53. Plausible is really my
only monthly charge at this point assuming I like it after my trial is over.
Note that Route 53 charged \$39 for my domain renewal, and Vercel will be
charging me \$50, plus the \$50 dollar charge to transfer the domain. Overall a
little bit of cost savings without the stress of managing my own web server.

[^1]: He is already on his way to making a new and improved site :).
[^2]: I haven't gotten to any other sections yet.
[^3]: Procrastination is my strong suit.
[^4]: Your mileage may vary.
