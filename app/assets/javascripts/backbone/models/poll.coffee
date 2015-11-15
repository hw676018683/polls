class App.Models.Poll extends Backbone.NestedAttributesModel
  defaults:
    title: ''
    description: ''
    cover: '/covers/cover-1.png'

  urlRoot: '/polls'
  paramRoot: 'poll'

  relations: [
    {
      key: 'questions'
      relatedModel: () ->
        App.Models.Question
    }
  ]

  subModels: []

  initialize: () =>
    questions = (@get 'questions').models
    @subModels.push question for question in questions
