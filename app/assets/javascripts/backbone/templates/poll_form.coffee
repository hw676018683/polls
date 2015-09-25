App.Templates.PollForm = _.template """
  <div class="poll">
    <img class="cover" src="<%= cover %>">
    <input class="title" placeholder="输入标题" type="text" value="<%= title %>">
    <textarea class="description"><%= description %></textarea>
  </div>
  <div class='questions'></div>
  <div class='card actions'>
    <button class='btn btn-outline js-save-poll'><i class='fa fa-save'></i> 保存</button>
    <button class='btn btn-success js-publish-poll'><i class='fa fa-envelope-o'></i> 发布</button>
  </div>
"""

App.Templates.DisableSavePollBtnReplacement = _.template """
  <i class='fa fa fa-spinner fa-pulse'></i> 保存中 ...
"""
App.Templates.DisablePublishPollBtnReplacement = _.template """
  <i class='fa fa fa-spinner fa-pulse'></i> 发布中 ...
"""
