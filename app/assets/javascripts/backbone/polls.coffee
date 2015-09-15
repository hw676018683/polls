window.App =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> console.log 'Hello from Backbone!'

$(document).ready ->
  App.initialize()
