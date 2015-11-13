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
        @_setStatus('保存成功') unless @hasError
      success: () -> @hasError = false
      error: @_saveError
      context: @

  publishPoll: (e)->
    e.stopPropagation()
    @_disableActionBtns()
    @_disableBtn(@$publishBtn)

    @model.save { status: 'published' },
      nested: true
      complete: ()=>
        @_enableActionBtns()
        @_enableBtn(@$publishBtn)
        @_setStatus('发布成功') unless @hasError
      success: () -> @hasError = false
      error: @_saveError
      context: @

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
    @hasError = true

    resJSON = response.responseJSON
    errorMsg = resJSON[Object.keys(resJSON)[0]]
    replacement = App.Templates.ErrorMsgPollStatusReplacement(errorMsg)()

    @_setStatus(replacement)

  _setStatus: (status) ->
    $statusDiv = $('.poll-status')
    $statusDiv.html(status)
