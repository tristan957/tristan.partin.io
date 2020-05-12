---
title: "Writing an API Wrapper in C: The Request"
date: 2020-05-05T22:24:39-05:00
draft: true
---

The second article in the _Writing an API Wrapper in C_ series. Requests, no not
your please and thank yous, but your `GET`s and `POST`s.

<!--more-->

In your everyday life, you'll make requests of friends and colleagues. You make
make 10s of requests a day. Your electronic devices are making **tens of
thousands**, if not more, requests a day. These requests can take the form RPC
messages, IPC messages through DBus, or in the case we are talking about today
Hypertext Transaction Protocol requests.

Previously we left off the API client. We saw an API for executing requests in
both a synchronous and asynchronous fashion. We will look at the definition of
our request object and how the API client acts upon it.

## `HarvestRequest`

`HarvestRequest` is essentially a composition of all the necessary data to
compose a
{{< externalLink "https://developer.gnome.org/libsoup/stable/SoupMessage.html" "SoupMessage" >}}
along with information stored in the`HarvestApiClient`.

```c
// harvest-request.h
#define HARVEST_TYPE_REQUEST (harvest_request_get_type())
G_DECLARE_DERIVABLE_TYPE(HarvestRequest, harvest_request, HARVEST, REQUEST, GObject)

struct _HarvestRequestClass
{
  GObjectClass parent_class;

  char *(*serialize_query_params)(HarvestRequest *);
};

// harvest-request.c
typedef struct _HarvestRequestPrivate
{
  HttpMethod http_method;
  char *endpoint;
  GValue *data;
  HarvestResponseMetadata *response_metadata;
} HarvestRequestPrivate;

G_DEFINE_ABSTRACT_TYPE_WITH_PRIVATE(HarvestRequest, harvest_request, G_TYPE_OBJECT)
```

We declare `HarvestRequest` as an abstract class with a single function to
implement `serialize_query_params`. Essentially converting request parameters
URL query parameters to a string. The we've got four member variables in the
private section of the `struct`.

- `http_method` - `GET`, `POST`, etc.
- `endpoint` - The specific endpoint to hit (`/users/me`)
- `data` - A nullable value that contains the body of the request
- `response_metadata` - Metadata about the response (defined below)

```c
// TODO: Make the response metadata GBoxed and not GObject
```

### An Implementation
