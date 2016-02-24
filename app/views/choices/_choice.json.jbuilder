json.(choice, :id, :title, :limit)

if 'true' == params[:fill]
  json.usersLength choice.user_ids.length
else
  json.user_ids choice.user_ids
  json.user_avatars User.where(id: choice.user_ids[0..4]).pluck(:headimgurl).map(&:to_s)
end
