class App.Views.PollForm extends Backbone.View
  template: App.Templates.PollForm

  events:
    'click .js-save-poll': 'savePoll'
    'click .js-publish-poll': 'savePoll'

  initialize: () ->
    @render()

  render: () ->
    self = @

    form_html = this.template(this.model.attributes)
    @$el.html(form_html)
    description_editor = Polls.initEditor @$('.description')

    @$title = @$('.title')
    @$title.change () =>
      @model.set title: @$title.val().trim()

    @$description = @$('.description')
    description_editor.on 'valuechanged', () ->
      self.model.set description: @getValue()

    @$el.find('.questions').replaceWith @questionsView().el
    @

  questionsView: () ->
    new App.Views.Questions
      collection: @model.get('questions')

  # Events
  savePoll: (e)->
    e.stopPropagation()

    @model.save {},
      nested: true
