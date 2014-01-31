## Ember SEO

**Note: this gem is currently a work in progress.**

This gem helps make Ember sites SEO friendly by:

* implementing hashbang urls in your Ember app
* providing a rake task that crawls your site and takes a static snapshot
* serving the correct static files to Google by properly handling requests with `_escaped_fragment_`

### Installation

Add it to your Gemfile:

`gem 'ember-seo'`


Create routes to display your static site:

```
class StaticConstraint
   def matches?(request)
      request.url.include?("_escaped_fragment_")
   end
end

YourApp::Application.routes.draw do
  get '/', to: 'static#show', constraints: StaticConstraint.new
  get '*path', to: 'static#show', constraints: StaticConstraint.new
end
```

Create a controller to handle these requests:

```
class StaticController < ApplicationController

  def show
    file_name = request.params["_escaped_fragment_"]
    file_name = "index" unless file_name.present?
    render file: "public/static/#{file_name}.html", layout: false
  end

end
```

Ensure that your Ember app is using hashbang urls by doing the following:

1. Add this hashbang location helper to app/models or app/assets/javascripts/models:

```
Ember.Location.registerImplementation("hashbang", Ember.HashLocation.extend({
  getURL: function() {
    return Ember.get(this, "location").hash.substr(2);
  },
  setURL: function(path) {
    Ember.get(this, "location").hash = "!" + path;
    return Ember.set(this, "lastSetURL", path);
  },
  onUpdateURL: function(callback) {
    var guid, self;
    self = this;
    guid = Ember.guidFor(this);
    return Ember.$(window).bind("hashchange.ember-location-" + guid, function() {
      return Ember.run(function() {
        var path;
        path = location.hash.substr(2);
        if (Ember.get(self, "lastSetURL") === path) {
          return;
        }
        Ember.set(self, "lastSetURL", null);
        return callback(path);
      });
    });
  },
  formatURL: function(url) {
    return "#!" + url;
  }
}));
```

2. Modify your Ember router to use hashbang:

```
App.Router.reopen({
  location: 'hashbang'
});
```

## Usage

Set the starting paths for the crawler in your environment file.

```
config.ember_seo_starting_paths = ['/', '/posts', '/etc']
```

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
