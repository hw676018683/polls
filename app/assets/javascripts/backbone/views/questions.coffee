class App.Views.Questions extends Backbone.View
  tagName: 'div'
  className: "questions",

  template: App.Templates.Questions

  events:
    'click .js-add-question': 'addQuestion'

  initialize: () ->
    @render()

  render: () ->
    @listenTo(@collection, 'add', @add)

    @$el.html @template()

    @$addQuestionBtn = @$('.js-add-question')

    @collection.each (question) =>
      @add(question)

  add: (question) ->
    questionView = new App.Views.Question model: question
    @$addQuestionBtn.before(questionView.render().el)

  remove: (question) ->
    @collection.remove(question)


  # Events
  addQuestion: (e) ->
    e.stopPropagation()

    @collection.push new App.Models.Question
      choices: new App.Models.Choice

