class App.Views.PollForm extends Backbone.View
  template: App.Templates.PollForm

  events:
    'click .js-save-poll': 'savePoll'
    'click .js-publish-poll': 'publishPoll'
    'click .submitBtn': 'submitPoll'

  initialize: (options) ->
    if options.method then @render(options.method) else @render('edit')

  render: (method) ->
    self = @
    @method = method

    form_html = this.template(method)(this.model.attributes)
    @$el.html(form_html)

    if 'edit' == method
      description_editor = Polls.initEditor @$('.description')

      @$saveBtn = @$('.actions button.js-save-poll')
      @$publishBtn = @$('.actions button.js-publish-poll')

      @$title = @$('.title')
      @$title.change () =>
        @model.set title: @$title.val().trim()
      @$title.blur () =>
        @model.isValid()

      @$description = @$('.description')
      description_editor.on 'valuechanged', () ->
        self.model.set description: @getValue()

      @$started_at = @$('.started_at')
      @$started_at.change ()=>
        @model.set started_at: @$started_at.val()

      @$ended_at = @$('.ended_at')
      @$ended_at.change ()=>
        @model.set ended_at: @$ended_at.val()

      pollAttributes = localStorage.getItem 'poll'
      if pollAttributes
        @_setStatus App.Templates.RecoverPollLinkReplacement
        $('#recover-poll').on 'click', {pollAttributes: pollAttributes}, (event) =>
          poll = new App.Models.Poll(JSON.parse(event.data.pollAttributes))
          @_recoverFrom poll
      @model.validate = @_validate

    if 'fill' == method
      if @model.writable()
        @$el.append App.Templates.FillActionReplacement
      else if @model.started()
        @$el.append App.Templates.Ended
      else
        @$el.append App.Templates.NotStarted

      @$submitBtn = $('.submit')

    if 'show' == method
      @$el.append App.Templates.ShowActionReplacement
      $('.collapseBtn').click () ->
        $('.description').slideToggle()
        collapseBtnReplacement = if $(this).html() == '收起描述'
                                   '展开描述'
                                 else
                                   '收起描述'
        $(this).html(collapseBtnReplacement)

      App.pollsChannel = App.cable.subscriptions.create { channel: "PollsChannel", poll_id: @model.id },
        received: (data) ->
          id = "choice_#{data['id']}"
          $("##{id}").text(data['select_count'])

    @$el.find('.questions').replaceWith @questionsView().el
    Backbone.trigger('render:complete')
    @questionsRendered = true

    @

  questionsView: () ->
    new App.Views.Questions
      collection: @model.get('questions')
      parent: @model
      method: @method

  # Events
  savePoll: (e)->
    e.stopPropagation()
    @_disableActionBtns()
    @_disableBtn(@$saveBtn)

    result = @model.saveWithNestedValidation {}  ,
      nested: true
      complete: ()=>
        @_enableActionBtns()
        @_enableBtn(@$saveBtn)
      success: () =>
        @_setStatus('保存成功')
        window.setTimeout(@_autoSave, 1*60*1000) if localStorage
      error: @_saveError

    @_setStatus('保存失败') if !result

  publishPoll: (e)->
    e.stopPropagation()
    @_disableActionBtns()
    @_disableBtn(@$publishBtn)

    result = @model.saveWithNestedValidation { status: 'published' },
      nested: true
      complete: ()=>
        @_enableActionBtns()
        @_enableBtn(@$publishBtn)
      success: (model, response, options)=>
        window.location = options.xhr.getResponseHeader('Location')
      error: @_saveError

    @_setStatus('发布失败') if !result

  submitPoll: (e) ->
    choice_ids = []

    for question in @model.get('questions').models
      for choice in question.get('choices').models
        choice_ids.push choice.get('id') if -1 == choice.get('usersLength')

    if choice_ids.length
      $.ajax
        method: 'post'
        contentType: 'application/json'
        url: "/polls/#{@model.id}/votes"
        data: JSON.stringify {result: choice_ids}
        success: (data, textStatus, jqXHR)=>
          window.location = jqXHR.getResponseHeader('Location')
        error: (jqXHR, textStatus, errorThrown)=>
          @_setStatus jqXHR.responseJSON.errors.join(',')

    else
      @_setStatus '请填写表单！'

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

  _saveError: (model, response, options) =>
    resJSON = response.responseJSON
    errorMsg = resJSON[Object.keys(resJSON)[0]]
    replacement = App.Templates.ErrorMsgPollStatusReplacement({errorMsg: errorMsg})

    @_setStatus(replacement)

  _setStatus: (status) ->
    $statusDiv = $('.poll-status')
    $statusDiv.html(status)

  _validate: (attrs, options) =>
    options.complete?()

    if !attrs.title.trim()
      $('.poll').addClass('error').children('.title').addClass('error')
      return 'error'
    else
      if $('.poll').hasClass('error')
        $('.poll').removeClass('error').children('.title').removeClass('error')
        return undefined

  _autoSave: () =>
    time = new Date()
    replacement = "#{time.getHours()}：#{time.getMinutes()} 自动保存"

    pollAttributes = JSON.stringify(@model.toJSON())
    localStorage.setItem 'poll', pollAttributes

    @_setStatus(replacement)

    window.setTimeout(@_autoSave, 1*60*1000)

  _recoverFrom: (poll) =>
    @model = poll
    @questionsRendered = false
    @render('edit')
    @_autoSave()
    @_setStatus('恢复成功')
