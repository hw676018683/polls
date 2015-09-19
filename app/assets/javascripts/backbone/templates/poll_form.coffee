App.Templates.PollForm = _.template """
  <div class="poll">
    <img src="<%= cover %>">
    <input class="title" placeholder="输入标题" type="text" value="<%= title %>">
    <textarea class="description"><%= description %></textarea>
  </div>
  <div class='questions'></div>
  <div class='card actions'>
    <button class='btn btn-success'><i class='fa fa-save'></i> 保存</button>
    <button class='btn btn-outline'><i class='fa fa-envelope-o'></i> 发布</button>
  </div>
"""
