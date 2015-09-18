App.Templates.Choice = _.template """
  <input class="title" placeholder="输入标题" type="text" value="<%= title %>">
  <input class="limit" placeholder="输入限制" type="text" value="<%= limit %>">
  <span class='js-remove-choice'>remove choice</span>
"""
