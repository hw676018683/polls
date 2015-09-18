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

