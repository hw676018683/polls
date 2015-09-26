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
