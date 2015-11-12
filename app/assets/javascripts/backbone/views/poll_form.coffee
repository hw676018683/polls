class App.Views.PollForm extends Backbone.View
  template: App.Templates.PollForm

  events:
    'click .js-save-poll': 'savePoll'
    'click .js-publish-poll': 'publishPoll'

  initialize: () ->
    @render()

  render: () ->
    self = @

    form_html = this.template(this.model.attributes)
    @$el.html(form_html)
    description_editor = Polls.initEditor @$('.description')

    @$saveBtn = @$('.actions button.js-save-poll')
    @$publishBtn = @$('.actions button.js-publish-poll')

    @$title = @$('.title')
    @$title.change () =>
      @model.set title: @$title.val().trim()

    @$description = @$('.description')
    description_editor.on 'valuechanged', () ->
      self.model.set description: @getValue()

    @$el.find('.questions').replaceWith @questionsView().el

    @hasError = false

    @

  questionsView: () ->
    new App.Views.Questions
      collection: @model.get('questions')

  # Events
  savePoll: (e)->
    e.stopPropagation()
    @_disableActionBtns()
    @_disableBtn(@$saveBtn)

    @model.save {}  ,
      nested: true
      complete: ()=>
        @_enableActionBtns()
        @_enableBtn(@$saveBtn)
      success: @_saveSuccess
      error: @_saveError

  publishPoll: (e)->
    e.stopPropagation()
    @_disableActionBtns()
    @_disableBtn(@$publishBtn)

    @model.save { status: 'published' },
      nested: true
      complete: ()=>
        @_enableActionBtns()
        @_enableBtn(@$publishBtn)
      success: @_saveSuccess
      error: @_saveError

  # Private
  _enableActionBtns: ()->
    @$saveBtn.prop('disabled', false)
    @$publishBtn.prop('disabled', false)

  _disableActionBtns: ()->
    @$saveBtn.prop('disabled', true)
    @$publishBtn.prop('disabled', true)


  _enableBtn: (btn) ->
    replacement = btn.data('bb:enable-with')

    btn.html(replacement)

  _disableBtn: (btn)->
    btn.data('bb:enable-with', btn.html())
    replacement = if btn.hasClass('js-publsh-poll')
                    App.Templates.DisablePublishPollBtnReplacement
                  else
                    App.Templates.DisableSavePollBtnReplacement

    btn.html(replacement)

  _saveError: (model, response, options) ->
    if @hasError
      $('.errors').html('')
    else
      @hasError = true
      $('.error-msg').slideToggle('fast')

    for attr, errorMsg of response.responseJSON
        $('.errors').append('<li>' + errorMsg + '</li>')

  _saveSuccess: (model, response, options) ->
    if @hasError
      @hasError = false
      $('.errors').html('')
      $('.error-msg').slideToggle('fast')
