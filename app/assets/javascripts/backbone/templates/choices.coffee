App.Templates.Choices = (method) ->
  if 'edit' == method
    return _.template """
      <div class="actions">
        <span class="btn btn-primary js-add-choice">+</span>
      </div>
    """
  else if 'fill' == method
    return ''
