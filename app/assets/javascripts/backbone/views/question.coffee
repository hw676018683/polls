class App.Views.Question extends Backbone.View
  tagName: 'div'
  className: "question",

  template: App.Templates.Question

  events:
    'click .js-remove-question': 'removeQuestion'
    'click .js-toggle-question': 'toggleQuestion'

  render: () ->
    @listenTo(@model, 'remove', @remove)

    @$el.html @template(@model.attributes)

    @$title = @$('.input')
    @$title.change () =>
      @model.set title: @$title.val().trim()

    @$el.append @choicesView().el

    @$choicesBody = @$('.choices')

    @

  choicesView: () ->
    new App.Views.Choices
      collection: @model.get('choices')

  # Events
  removeQuestion: (e) ->
    e.stopPropagation()

    @$el.slideUp 'fast', () =>
      @model.destroy()

  # Events
  toggleQuestion: (e) ->
    e.stopPropagation()

    @$choicesBody.slideToggle()
    @$('.js-toggle-question').toggleClass('fa-angle-up')
    @$('.js-toggle-question').toggleClass('fa-angle-down')

