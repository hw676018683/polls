App.Templates.PollForm = (method) ->
  if 'edit' == method
    return _.template """
      <div class="poll">
        <img class="cover" src="<%= cover %>">
        <input class="title" placeholder="输入标题" type="text" value="<%= title %>">
        <textarea class="description"><%= description %></textarea>
      </div>
      <div class='questions'></div>
      <div class='card actions'>
        <div class='poll-status'>编辑完成？</div>
        <button class='btn btn-success js-publish-poll'><i class='fa fa-envelope-o'></i> 发布</button>
        <button class='btn btn-outline js-save-poll'><i class='fa fa-save'></i> 保存</button>
      </div>
      """
  else if 'fill' == method
    return _.template """
      <div class="poll fill">
        <img class="cover" src="<%= cover %>">
        <div class="title"><%= title %></div>
        <div class="description"><%= description%></div>
      </div>
      <div class='questions fill'><div>
    """
  else if 'show' == method
    return _.template """
      <div class="poll item-show">
        <img class="cover" src="<%= cover %>">
        <div class="title"><%= title %></div>
        <div class="description"><%= description%></div>
        <div class="action">
          <a class="btn collapseBtn" href="#">收起描述</a>
        </div>
      </div>
      <div class='questions item-show'><div>
    """

App.Templates.DisableSavePollBtnReplacement = _.template """
  <i class='fa fa fa-spinner fa-pulse'></i> 保存中 ...
"""
App.Templates.DisablePublishPollBtnReplacement = _.template """
  <i class='fa fa fa-spinner fa-pulse'></i> 发布中 ...
"""

App.Templates.ErrorMsgPollStatusReplacement = _.template """
    <i class='fa fa fa-frown-o'></i> <%= errorMsg %>
  """

App.Templates.RecoverPollLinkReplacement = _.template """
    <a id='recover-poll' href='#'>点击恢复本地存档</a>
  """

App.Templates.FillActionReplacement = _.template """
    <div class='card actions fill'>
      <div class='poll-status'>填写完毕？</div>
      <a class='btn submitBtn' href='#'>提交</a>
    </div>
"""
