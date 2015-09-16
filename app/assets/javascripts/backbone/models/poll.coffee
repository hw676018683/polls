class App.Models.Poll extends Backbone.Model
  defaults:
    title: ''
    description: ''

  initialize: () ->
    @set questions: new App.Collections.Questions()

