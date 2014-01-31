Ember.Location.registerImplementation "hashbang", Ember.HashLocation.extend
  getURL: ->
    Ember.get(this, "location").hash.substr 2

  setURL: (path) ->
    Ember.get(this, "location").hash = "!" + path
    Ember.set(this, "lastSetURL", path)

  onUpdateURL: (callback) ->
    self = this
    guid = Ember.guidFor(this)
    Ember.$(window).bind "hashchange.ember-location-" + guid, ->
      Ember.run ->
        path = location.hash.substr(2)
        return if Ember.get(self, "lastSetURL") is path
        Ember.set(self, "lastSetURL", null)
        callback path

  formatURL: (url) ->
    "#!" + url
