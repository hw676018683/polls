class App.Models.Question extends Backbone.NestedAttributesModel
  defaults:
    title: ''
    multiple: false

  relations: [
    {
      key: 'choices'
      relatedModel: () ->
        App.Models.Choice
    }
  ]

  subModels: []

  initialize: () =>
    choices = (@get 'choices').models
    @subModels.push choice for choice in choices
