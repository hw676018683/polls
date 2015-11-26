class App.Views.Choices extends Backbone.View
  tagName: 'div'
  className: 'choices'
  template: App.Templates.Choices

  events:
    'click .js-add-choice': 'addChoice'

  initialize: (options) ->
    @parent = options.parent if options.parent

    if options.method then @render(options.method) else @render('edit')

  render: (method) ->
    @method = method

    @$el.html @template(method)

    if 'edit' == method
      @listenTo(@collection, 'add', @add)
      @$actions = @$('.actions')
    else if 'fill' == method
      @$el.addClass 'fill'

    @collection.each (choice) =>
      @add(choice)

  add: (choice) ->
    choiceView = new App.Views.Choice
      model: choice
      multiple: @parent.get('multiple')
      questionId: @parent.get('id')
    if 'edit' == @method
      @$actions.before(choiceView.render(@method).el)
    else if 'fill' == @method
      @$el.append(choiceView.render(@method).el)
      Backbone.on 'render:complete', choiceView.initiCheck, choiceView

  # Events
  addChoice: (e) ->
    e.stopPropagation()

    choice = new App.Models.Choice

    @collection.push choice

    @parent.subModels.push choice
