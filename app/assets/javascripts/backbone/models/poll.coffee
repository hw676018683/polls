class App.Models.Poll extends Backbone.NestedAttributesModel
  defaults:
    title: ''
    description: ''

  relations: [
    {
      key: 'questions'
      relatedModel: () ->
        App.Collections.Questions
    }
  ]

  initialize: () ->
    @.get('questions').push new App.Models.Question


