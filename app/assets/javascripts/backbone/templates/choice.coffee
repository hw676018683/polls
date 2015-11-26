App.Templates.Choice = (method) ->
  if 'edit' == method
    return _.template """
      <div class='title'>
        <input placeholder="输入选项" type="text" value="<%= title %>">
      </div>
      <div class='limit'>
        <input placeholder="输入限额" type="text" value="<%= limit %>">
      </div>
      <span class='actions'>
        <i class='fa fa-trash-o action js-remove-choice'></i>
      </span>
    """
  else if 'fill' == method
    return _.template """
      <% if (this.multiple) { %>
        <input class='choice-button' type='radio' name="#{this.questionId}">
      <% } else { %>
        <input class='choice-button' type='checkbox' name="#{this.questionId}">
      <% } %>
      <div class='title fill'><%= title %></div>
      <% if (limit) { %>
       <div class='limit fill'>剩余 <%= limit - usersLength %></div>
      <% } %>
    """
