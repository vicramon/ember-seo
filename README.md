## Ember SEO

**Note: this gem is currently a work in progress.**

This gem helps make Ember sites SEO friendly by:

* implementing hashbang urls in your Ember app
* providing a rake task that crawls your site and takes a static snapshot
* serving the correct static files to Google by properly handling requests with `_escaped_fragment_`

### Installation

#### Bundle & Install

Add it to your Gemfile:

`gem 'ember-seo'`
`bundle`

Run the generator:

`rails g ember_seo:install`

This creates rails routes and a controller to display your static site.


#### Setup

Modify your Ember router to use hashbang:

```
var Router = Ember.Router.extend({
  location: 'hashbang'
});
```

Set the starting paths for the crawler in your environment file.

```
config.ember_seo_starting_paths = ['/', '/posts', '/etc']
```

## Usage

Run the crawler:

```
rake emberseo:scrape
```

This takes a snapshot of your site and saves it to public/static.

Now visit a url in your app, for example:

`http://localhost:3000/#!/posts`, and replace `#!` with `?_escaped_fragment=` like so:
`http://localhost:3000/?_escaped_fragment_=posts` and you should see the correct static file. View
the source of the page to ensure that you are viewing the static file and not your Ember
application.
