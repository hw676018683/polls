App.Templates.Choice = _.template """
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
