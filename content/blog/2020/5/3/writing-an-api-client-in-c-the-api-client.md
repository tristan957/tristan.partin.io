---
title: "Writing an API Wrapper in C: The API Client"
date: 2020-05-03T17:00:03-05:00
categories:
  - programming
tags:
  - c
  - webdev
  - glib
series:
  - writing-an-api-wrapper-in-c
---

Welcome to the first blog in a series I will be calling _Writing an API Wrapper
in C_. I'll be talking about **the API client** in the first article.

<!--more-->

API wrappers are extremely common as interfaces for data have moved from system
libraries to the web. Libraries buy you first class language interaction with
your data while web interfaces generally lack type checking like a compiler or
interpreter would provide.

Enter API wrappers.

API wrappers represent first-class language contracts for interacting with data
or services over the web. They allow you to use the niceties of your language of
choice using an abstraction over a web interface.

API wrappers typically come in much higher-level languages like Go, Python,
JavaScript, Java, and C#, but in this blog I will show you how to make an API
wrapper in C. For the purpose of the series, I will be borrowing code from my
project
{{< externalLink "https://git.sr.ht/~tristan957/harvest-glib" "harvest-glib" >}}
which I make use of in my other project
{{< externalLink "https://git.sr.ht/~tristan957/harvest-almanac" "Harvest Almanac" >}}.
We will be taking a look at the
{{< externalLink "https://www.getharvest.com/" "Harvest" >}} API. The docs can
be found here:
{{< externalLink "https://help.getharvest.com/api-v2/" "Harvest API Documentation" >}}.
Harvest is a service for tracking time and expenses on projects. We use it at
work often.

Technologies I will be showcasing within the series include:

- `GLib` - Expanded standard library for C.
- `GObject` - Object-oriented type system for C. I could spend forever talking
  about this alone, but it wouldn't really stay on topic. If you see anything
  confusing, email me or leave a comment.
- `libsoup` - GLib-based HTTP library.
- `json-glib` - JSON support for GLib.

You might be saying, "Tristan, but C lacks all the niceties that higher-level
languages have so this feels like a waste of time." And to that I say time is
only wasted if you don't see value. Let's call this an exercise of the mind and
dive right into the first topic in the series: Creating an API Client.

## `HarvestApiClient`

An API client is the object that will execute requests, and format responses
into language constructs like objects and errors. Generally APIs will require
some form of authentication along with any special headers that may need to be
set. The Harvest API requires authentication, so I generated a developer token.
It also requires a few other parameters, like an account ID, and a user agent
including a contact email. Here is how I am creating a Harvest API client in C.

```c
// harvest-api-client.h
HarvestApiClient *harvest_api_client_new(SoupSession *session, const char *access_token,
  const char *account_id) G_GNUC_WARN_UNUSED_RESULT;

// my-code.c
g_autoptr(SoupSession) session = soup_session_new_with_options(SOUP_SESSION_MAX_CONNS,
  4, SOUP_SESSION_USER_AGENT, "HarvestAlmanac (me@example.com)", SOUP_SESSION_ADD_FEATURE_BY_TYPE,
  SOUP_TYPE_CONTENT_SNIFFER, NULL);

// CLIENT is a singleton that will handle all my Harvest API interactions
HarvestApiClient *CLIENT = harvest_api_client_new(session, access_token, account_id);
```

It would probably help to see a little bit of the definition of
`HarvestApiClient`.

```c
// harvest-api-client.c
struct _HarvestApiClient
{
  GObject parent_instance;

  SoupSession *session;
  char *server; // Base URL of the API, in this case always "https://api.harvestapp.com/v2"
  char *access_token;
  char *account_id;
};
```

These struct members and the request object I am given are all that I need to
successfully make a request to the Harvest API. The API client has two public
functions to be aware of.

```c
// harvest-api-client.h
HarvestResponse *harvest_api_client_execute_request_sync(
  HarvestApiClient *self, HarvestRequest *req);
void harvest_api_client_execute_request_async(HarvestApiClient *self, HarvestRequest *req);
```

You see the types `HarvestRequest` and `HarvestResponse` in the code. We will
ignore that for now since it will be talked about later in the series. Just know
`HarvestRequest` includes the body, the HTTP method, the API endpoint, and
metadata about what constitutes a successful response, while `HarvestResponse`
includes the deserialized response object, the error if there was one, and the
received status code.

We are good developers so we provide both an asynchronous and synchronous way to
use our client. Benefits of the synchronous API include blocking calls, while
the asynchronous API can benefit graphical interfaces or event loop style
programs where you react to events. The implementations of the execution
functions will be covered later when we talk about `HarvestRequest` and
`HarvestResponse` because they go hand in hand.

Hopefully this blog post was enough to trigger your interest in the series as
there is more content to come.
