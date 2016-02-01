class App.Views.Questions extends Backbone.View
  tagName: 'div'
  className: "questions",

  template: App.Templates.Questions

  events:
    'click .js-add-question': 'addQuestion'

  initialize: (options) ->
    @parent = options.parent if options.parent

    if options.method then @render(options.method) else @render('edit')

  render: (method) ->
    @method = method

    @$el.html @template(method)

    if 'edit' == method
      @listenTo(@collection, 'add', @add)
      @$addQuestionBtn = @$('.js-add-question')
    else if 'fill' == method
      @$el.addClass 'fill'
    else if 'show' == method
      @$el.addClass 'item-show'

    @collection.each (question) =>
      @add(question)

  add: (question) ->
    questionView = new App.Views.Question model: question
    if 'edit' == @method
      @$addQuestionBtn.before(questionView.render('edit').el)
    else
      @$el.append(questionView.render(@method).el)

    # iCheck after render on dom
    if poll_form.questionsRendered
      questionView.initMultiple()
    else
      Backbone.on('render:complete', questionView.initMultiple, questionView)

  remove: (question) ->
    @collection.remove(question)


  # Events
  addQuestion: (e) ->
    e.stopPropagation()

    choice = new App.Models.Choice
    question = new App.Models.Question choices: choice

    @collection.push question

    @parent.subModels.push question
