class App.Views.Question extends Backbone.View
  tagName: 'div'
  className: "question",

  template: App.Templates.Question

  render: () ->
    @listenTo(@model, 'destroy', @remove)

    @$el.html @template(@model.attributes)

    @$title = @$('.title')
    @$title.change () =>
      @model.set title: @$title.val().trim()

    @

