class App.Views.Questions extends Backbone.View
  tagName: 'div'
  className: "questions",

  template: App.Templates.Questions

  events:
    'click .js-add-question': 'addQuestion'

  initialize: (options) ->
    @parent = options.parent if options.parent

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
    # iCheck after render on dom
    questionView.initMultiple()

  remove: (question) ->
    @collection.remove(question)


  # Events
  addQuestion: (e) ->
    e.stopPropagation()

    choice = new App.Models.Choice
    question = new App.Models.Question choices: choice

    @collection.push question

    @parent.subModels.push question
