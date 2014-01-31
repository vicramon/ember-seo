## Ember SEO

**Status**

This gem successfully creates a snapshot of your site on your local server and properly serves it up with escaped fragement. However, I am unsure if the escaped fragment pattern is exactly correct and if this will actually work with Google.

Additionally, hashbang urls are really ugly, so I'd like for the router to determine if the request is from a Google bot and only then use hashbangs.


**Introduction**

This gem helps make Ember sites SEO friendly by:

* implementing hashbang urls in your Ember app
* providing a rake task that crawls your site and takes a static snapshot
* serving the correct static files to Google by properly handling requests with `_escaped_fragment_`

### Installation

#### Bundle & Install

Add it to your Gemfile:

`gem 'ember-seo'`

Run the generator:

`rails g ember_seo:install`

This creates Rails routes, a Rails controller to display your static site, and app/models/hashbang.js which has a hashbang location helper. If you're not using Ember Appkit Rails then you should move hashbang.js to app/assets/javascripts/models.


#### Setup

Modify your Ember router to use hashbang:

```
var Router = Ember.Router.extend({
  location: 'hashbang'
});
```

Set the starting paths for the crawler in your environment file:

```
config.ember_seo_starting_paths = ['/', '/posts', '/etc']
```

## Usage

Make sure your server is running on localhost:3000 then run the crawler:

```
rake emberseo:scrape
```

This takes a snapshot of your site and saves it to public/static.

Now visit a url in your app, for example:

`http://localhost:3000/#!/posts`, and replace `#!` with `?_escaped_fragment=` like so:
`http://localhost:3000/?_escaped_fragment_=posts` and you should see the correct static file. View
the source of the page to ensure that you are viewing the static file and not your Ember
application.
