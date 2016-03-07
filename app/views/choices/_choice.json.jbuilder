json.(choice, :id, :title, :limit)

if 'true' == params[:fill]
  json.usersLength choice.select_count
else
  json.usersLength choice.select_count
  json.user_avatars User.where(id: choice.entities.pluck(:user_id).uniq).pluck(:headimgurl)[0..4].map(&:to_s)
end
