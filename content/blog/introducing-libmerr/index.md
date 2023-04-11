---
title: "Introducing libmerr"
date: 2023-04-10T20:46:39-05:00
toc: false
---

[`libmerr`](https://github.com/tristan957/libmerr) is a error tracking static
library for C99+. During this [involuntary
vacation]({{< relref "blog/i-got-laid-off/index.md">}}), I have spent some time
taking code out of the
[Heterogeneous-Memory Storage Engine](https://github.com/hse-project/hse) (HSE).

<!--more-->

C is a notoriously bad language when it comes to error handling. Many
system/POSIX/UNIX APIs will return various values on error or set
[`errno(3)`](https://linux.die.net/man/3/errno). An integer error value can
generally tell you the reason an error occurred, but it doesn't provide extra
information like file, line number, or any extra context.

To overcome this issue, the authors of the
[Heterogeneous-Memory Storage Engine](https://github.com/hse-project/hse) (HSE)
came up with `merr`. An `merr_t` is an error value which can encode all this
information in just a 64-bit unsigned integer. This repository is essentially a
copy and paste of what exists within HSE. Because of that you will see the
original `Micron Technology, Inc.` copyright in addition to the dual licensing
of this code as `Apache-2.0` or `MIT` depending on what best fits within your
constraints.

`libmerr` can be used in the following ways:

```c
// file.c

#include <errno.h>
#include <stdio.h>

#include <merr.h>

enum my_ctx
{
  CTX1 = 1,
};

static const char *
my_ctx_strerror(uint16_t ctx)
{
  switch ((enum my_ctx)ctx) {
  case CTX1:
    return "ctx1";
  }
}

static merr_t
func1(void)
{
  return merr(EINVAL);
}

static merr_t
func2(void)
{
  return merrx(ENOENT, CTX1);
}

static void
caller(void)
{
  char buf[256];

  merr_t err1 = func1();
  merr_strerror(err1, buf, sizeof(buf), NULL);
  fprintf(stderr, "%s\n", buf);
  // file.c:25: Invalid argument (22)

  merr_t err2 = func2();
  merr_strerror(err2, buf, sizeof(buf), NULL);
  fprintf(stderr, "%s\n", buf);
  // file.c:31: No such file or directory (2): ctx1 (1)
}
```

There are a few other functions in the header file for getting the error, file,
line number, and context should you need them. Refer to the
[repository](https://github.com/tristan957/libmerr) for more details.
