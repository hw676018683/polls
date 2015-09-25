class App.Models.Question extends Backbone.NestedAttributesModel
  defaults:
    title: ''

  relations: [
    {
      key: 'choices'
      relatedModel: () ->
        App.Models.Choice
    }
  ]
