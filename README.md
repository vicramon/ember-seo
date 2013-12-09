## Ember SEO

This is a **work in progress** set of files that make Ember sites SEO friendly by:

* implementing hashbang urls in your Ember app
* providing a rake task that crawls your site and takes a static snapshot
* serving the correct static files to Google by properly handling requests with `_escaped_fragment_`

### Usage

Copy all of the files into your app (I haven't gem-ified it just yet).

Make sure that your Ember app is using hashbang urls.

Open `lib/tasks/site_scraper.rake` and set the paths that you want the crawler to start on.

Run:

```
rake scrape
```

This takes a snapshot of your site and saves it to `public/static`

Now visit a url in your app, for example:

`http://localhost:3000/#!/posts`, and replace `#!` with `?_escaped_fragment=` like so:
`http://localhost:3000/?_escaped_fragment_=posts` and you should see the correct static file. View the source of the page to ensure that you are viewing the static file and not your Ember application.
