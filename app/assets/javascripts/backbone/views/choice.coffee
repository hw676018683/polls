class App.Views.Choice extends Backbone.View
  tagName: 'div'
  className: "choice",
  template: App.Templates.Choice

  events:
    'click .js-remove-choice': 'removeChoice'

  render: () ->
    @listenTo(@model, 'remove', @remove)

    @$el.html @template(@model.attributes)

    @$title = @$('.title input')
    @$title.change () =>
      @model.set title: @$title.val().trim()

    @$limit = @$('.limit input')
    @$limit.change () =>
      @model.set limit: (parseInt(@$limit.val().trim()) or 0)

    @

  # Events
  removeChoice: (e) ->
    e.stopPropagation()

    @model.destroy()
