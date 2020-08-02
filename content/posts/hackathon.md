+++
title = "Hackathon"
author = ["Jacob Chvatal"]
lastmod = 2020-08-01T19:21:02-07:00
slug = "hackathon"
draft = false
+++

Small ideas for hackathons or small periods of time.

These will each be eventually updated with their own posts as the ideas expand and they're given names.

The name is the most important part of a project. Without a good name the project will fail.


## Reddit Tree Navigation {#reddit-tree-navigation}

Remember Prezi? You could click on different bubbles
to navigate through a presentation nonlinearly, or could
navigate it linearly with forward and backwards arrow keys.

This has a lot of potential! Let's try it with Reddit threads.


### UX {#ux}

Visiting a reddit post and prefixing it with the reddit tree website's URL opens a window with the post's contents at the top of the webpage. Below this, there are lots of bubbles pseudorandomly scattered throughout the page. Their sizes are by default weighted by the number of upvotes on the comment, but they can be arranged by number of comments in the thread branching from the comment or some other metrics (TBD).

Each bubble has the username, number of upvotes, and the prefix of the comment. They may have smaller bubbles visible to demonstrate the next layer of comments in the tree.

Clicking on one of these bubbles does one of two things (not sure yet):

-   Moves the bubble to the top right of the screen
-   Replaces the text of the reddit post with that of the comment opened

Either way, the user now has access to a back button to go 'back up' in the tree (we define clicking on a bubble as 'going down' the tree), and they also can see all of the comments descended from the currently open comment as first-class bubbles.

Each of these pages will also havte a bubble with a plus sign on it in the bottom right of the page; clicking this opens a bubble that fills most of the screen, with the comment or post you're commenting on featured as a smaller bubble above it (perhaps it's visible as a semicircle under this bubble?). You can then make a reddit comment using the usual reddit facilities for this.


### Production {#production}


#### MVP {#mvp}

-   Visit a specific url on the reddit tree view website to open a reddit thread.
-   View the post and each comment in a bubble.
-   Click a bubble to view the next level of comments.


#### Enhanced UX {#enhanced-ux}

-   Tree view can be accessed by prefixing a reddit URL thread with our URL.
-   Post bubbles are sized proportionally to their number of upvotes or some other ranking metric. You can see smaller bubbles around them that provide an estimate of the number of comments in their assoc. thread.


#### Usable for Reddit {#usable-for-reddit}

-   The user can log in and make comments themselves.


#### Complete Product {#complete-product}

Rather than providing alternate views to individual threads, the program can instead act as its own reddit client.

The main page of the site functions just like Reddit's home page, only with bubbles for each subreddit.
The bubbles are weighted proportional to the number of new posts, popularity of those posts or some other metric.

When clicking on one of these subreddit bubbles, you open a secondary bubble view that showcases each post in the subreddit.
A UI is provided to make new posts in the subreddit from this page.

Clicking on an individual posts opens the fleshed out idea above, providing an alternative navigational experience for all of reddit.


## Version Control for Music {#version-control-for-music}

Live coding is a good idea, but it's meant to be 'played';
current solutions for persisting livecoding information require
recording, which compresses all of the structural information associated with the music, or meticulously copying and pasting code then saving it all.

We can do better!

A 'recording' mode for a live coding environment could be implemented.

To start the recording mode, a new branch is created.
Every time the file is updated and re-run, it's recorded as a git commit in a project's commit history.
The commit message has notation demonstrating how long a certain commit was played (time from start of recording to first commit or from the last commit to the current one).

When done recording, you can switch back to the main branch. The new branches are identified by a particular notation in the branch name to demonstrate that they were automatically created.

These recordings can be:

-   Played back. A menu is exposed to 'play' each of the created branches.
    When a branch is played, its first commit is run through the music interpreter for a specified amount of time, then the new commit is checked out and re-run; this is identical to a user manually editing the file and updating the played music, and tracks will only update if the code has been changed for them.
-   Exported: this can be done in the same way tracks are played back.
-   Converted to linear tracks. You can 'export' a branch to a linear arrangement to make it easier to edit and turn into a complete song without having to record it! This process generates the appropriate pauses in between the different parts of the music and loops to ensure that the different segments of the track are run at the right time and in the right order.
    This allows artists to take live coding projects that have been performed. convert them into full-fledged tracks, and export them without having to perform them.


## Spell Check Hook {#spell-check-hook}

I hate improper spelling or formatting.
A linter that checks for proper spelling in a project with git hooks!
You won't be able to commit to your projecct until you fix those spelling errors.


## GitHub README Information Generators {#github-readme-information-generators}

These are tools dynamically queried by README files that show information about specific projects.
They're lightweight and easily hosted.
<https://github.com/anuraghazra/github-readme-stats> is a good place to start for learning how to make one such banner.

Look into dynamically configuring and formatting text via a specific web query. Perhaps a server can be made to accept arbitrary html/css and output an image with this information?

I'll also need a tool for converting such a file into a URL-compatible version, see <https://stackoverflow.com/questions/1547899/which-characters-make-a-url-invalid#1547940>.