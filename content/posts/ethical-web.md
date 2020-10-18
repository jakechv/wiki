+++
title = "Ethical Web"
author = ["Jacob Chvatal"]
lastmod = 2020-10-18T20:27:04+02:00
slug = "ethical_web"
draft = false
+++

Backlinks
: [Web]({{< relref "web" >}})

Thoughts on the current state of the web and taking action to make it more ethical.

The modern web often forces all developers to adhere to more and more specifications (have you seen how long and convoluted the RFC manual is?), and lives in a world where only the companies that create the standards can practically adhere to them.

This is bad abstraction! This process is no different from forcing everyone who **uses** a technology to add specific components to their work rather than taking on this responsibility as the browser.

Of course, information like a robots.txt, a webpage title and these sorts of things should be standardized and mandated by the user -- but there are lots of sensible defaults, like keyboard-navigable websites, that could be applied and later overridden by the user if they don't like these defaults.

Not including these accessible features in a native application that runs these web services leads to substantial bloat and insecure (JavaScript) code execution to emulate accessiblity features that could easily be accepted by the browser, like onMouseKey functionality! What about using tab-enter to navigate links without having to tag said links with specific attributes?


## Web Minimalism {#web-minimalism}


### Size Compression {#size-compression}

There are transpilers and minifying tools, but to best optimize for small websites you might as well roll your own static site generator. I've been using Python's Jinja2 template engine but I'm sure there are better options.

Lots of resources suggest that your site, or its critical resources at the least, should fit in the first ten packets:

-   <https://www.tunetheweb.com/blog/critical-resources-and-the-first-14kb/>
-   <https://www.smashingmagazine.com/2020/01/front-end-performance-checklist-2020-pdf-pages/#setting-realistic-goals>
-   <https://tylercipriani.com/blog/2016/09/25/the-14kb-in-the-tcp-initial-window/>

There are obvious performance improvements to some actions as well:

-   <https://blog.logrocket.com/improve-site-performance-inlining-css/>
-   <https://www.filamentgroup.com/lab/load-css-simpler/>

[writing css with accessibility in mind](https://www.matuzo.at/blog/writing-even-more-css-with-accessibility-in-mind-user-preferences/)