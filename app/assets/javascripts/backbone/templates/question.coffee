App.Templates.Question = _.template """
  <div class='title'>
    <input class="input" placeholder="输入标题" type="text" value="<%= title %>">
    <div class='actions'>
      <i class='fa fa-trash-o action js-remove-question'></i>
      <i class='fa fa-angle-up action js-remove-question'></i>
    </div>
  </div>
"""

