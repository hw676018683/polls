class App.Views.Choices extends Backbone.View
  tagName: 'div'
  className: 'choices'
  template: App.Templates.Choices

  events:
    'click .js-add-choice': 'addChoice'

  initialize: (options) ->
    @parent = options.parent if options.parent

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

    choice = new App.Models.Choice

    @collection.push choice

    @parent.subModels.push choice
