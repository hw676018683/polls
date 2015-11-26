class App.Views.Choice extends Backbone.View
  tagName: 'div'
  className: "choice",
  template: App.Templates.Choice

  events:
    'click .js-remove-choice': 'removeChoice'

  initialize: (options) ->
    @multiple = options.multiple
    @questionId = options.questionId

  render: (method) ->
    @$el.html @template(method).call(this, @model.attributes)

    if 'edit' == method
      @listenTo(@model, 'remove', @remove)
      @$title = @$('.title input')
      @$title.change () =>
        @model.set title: @$title.val().trim()
      @$title.blur () =>
        @model.isValid()

      @$limit = @$('.limit input')
      @$limit.change () =>
        @model.set limit: (parseInt(@$limit.val().trim()) or '')
      @$limit.blur () =>
        @model.isValid()
      @model.validate = @_validate
    else if 'fill' == method
      @$el.addClass 'fill'

    @

  initiCheck: () =>
    Polls.initiCheck @$('input')

  # Events
  removeChoice: (e) ->
    e.stopPropagation()

    @model.collection.remove(@model)

  # Private

  _validate: (attrs, options) =>
    hasError = false
    $question = @$el.parent().parent()

    options.complete?()

    if !attrs.title.trim()
      @$title.addClass('error')
      hasError = true

    if attrs.limit && !((/^[1-9]+[0-9]*]*$/).test(attrs.limit))
      @$limit.addClass('error').attr('placeholder', '限额非法').val('')
      hasError = true

    if hasError
      $question.addClass('error')
      return 'error'
    else
      if @$title.hasClass('error')
        @$title.removeClass('error')
      if @$limit.hasClass('error')
        @$limit.removeClass('error')
      return undefined
