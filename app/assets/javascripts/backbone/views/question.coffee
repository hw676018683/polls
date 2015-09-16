class App.Views.Question extends Backbone.View
  tagName: 'div'
  className: "question",

  template: App.Templates.Question

  events:
    'click .js-remove-question': 'removeQuestion'

  render: () ->
    @listenTo(@model, 'remove', @remove)

    @$el.html @template(@model.attributes)

    @$title = @$('.title')
    @$title.change () =>
      @model.set title: @$title.val().trim()

    @

  # Events
  removeQuestion: (e) ->
    e.stopPropagation()

    @model.destroy()
