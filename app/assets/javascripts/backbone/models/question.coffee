class App.Models.Question extends Backbone.NestedAttributesModel
  defaults:
    title: ''

  relations: [
    {
      key: 'choices'
      relatedModel: () ->
        App.Collections.Choice
    }
  ]

  initialize: () ->
    @.get('choices').push new App.Models.Choice

