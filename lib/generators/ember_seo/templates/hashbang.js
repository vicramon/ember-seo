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
