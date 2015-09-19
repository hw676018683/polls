class App.Views.Choices extends Backbone.View
  tagName: 'div'
  className: 'choices'
  template: App.Templates.Choices

  events:
    'click .js-add-choice': 'addChoice'

  initialize: () ->
    @render()

  render: () ->
    @listenTo(@collection, 'add', @add)

    @$el.html @template()

    @$actions  = @$('.actions')

    @collection.each (choice) =>
      @add(choice)

  add: (choice) ->
    choiceView = new App.Views.Choice  model: choice
    @$actions.before(choiceView.render().el)

  # Events
  addChoice: (e) ->
    e.stopPropagation()

    @collection.push new App.Models.Choice

