class App.Models.Poll extends Backbone.NestedAttributesModel
  defaults:
    title: ''
    description: ''
    cover: '/covers/cover-1.png'

  urlRoot: '/polls'

  relations: [
    {
      key: 'questions'
      relatedModel: () ->
        App.Collections.Questions
    }
  ]

  initialize: () ->
    @.get('questions').push new App.Models.Question
