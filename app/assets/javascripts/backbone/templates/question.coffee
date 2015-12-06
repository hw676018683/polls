App.Templates.Question = (method) ->
  if 'edit' == method
    return _.template """
      <div class='title'>
        <input class="input" placeholder="输入问题" type="text" value="<%= title %>">
        <div class='actions'>
          <i class='fa fa-trash-o action js-remove-question'></i>
          <i class='fa fa-angle-up action js-toggle-question'></i>
        </div>
      </div>
      <div class='multiple'>
        <div class='multiple-item'>
          <input type='radio' name='<%= this.multipleName() %>' id='<%= this.multipleId(false) %>' value='0'>
          <label for='<%= this.multipleId(false) %>'>单选</label>
        </div>
        <div class='multiple-item'>
          <input type='radio' name='<%= this.multipleName() %>' id='<%= this.multipleId(true) %>' value='1'>
          <label for='<%= this.multipleId(true) %>'>多选</label>
        </div>
      </div>
    """
  else if 'fill' == method
    return _.template """
      <div class='title fill'><%= title %></div>
    """
  else if 'show' == method
    return _.template """
      <div class='title show'><%= title %></div>
    """
