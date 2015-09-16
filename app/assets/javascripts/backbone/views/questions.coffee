class App.Views.Questions extends Backbone.View
  tagName: 'div'
  className: "questions",

  template: App.Templates.Questions

  initialize: () ->
    @render()

  render: () ->
    @listenTo(@collection, 'add', @add)

    @collection.each (question) =>
      @add(question)

  add: (question) ->
    questionView = new App.Views.Question model: question
    @$el.append(questionView.render().el)

