App.Templates.Questions = (method) ->
  if 'edit' == method
    _.template """
      <span class='btn add-question-btn js-add-question'>+ 添加问题</span>
    """
  else if 'fill' == method
    ''
