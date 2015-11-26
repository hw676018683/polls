json.(choice, :id, :title, :limit)

if 'true' == params[:fill]
  json.usersLength choice.user_ids.length
else
  json.user_ids choice.user_ids
end
