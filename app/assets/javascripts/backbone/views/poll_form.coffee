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
    @

  questionsView: () ->
    new App.Views.Questions
      collection: @model.get('questions')

  # Events
  savePoll: (e)->
    e.stopPropagation()
    @_disableActionBtns()
    @_disableBtn(@$saveBtn)

    @model.save {},
      nested: true
      complete: ()=>
        @_enableActionBtns()
        @_enableBtn(@$saveBtn)

  publishPoll: (e)->
    e.stopPropagation()
    @_disableActionBtns()
    @_disableBtn(@$publishBtn)

    @model.save { status: 'published' },
      nested: true
      complete: ()=>
        @_enableActionBtns()
        @_enableBtn(@$publishBtn)

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
