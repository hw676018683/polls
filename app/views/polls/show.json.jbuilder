json.(@poll, :id, :title, :description, :started_at, :ended_at, :time_description)

json.user do
  json.partial! partial: 'users/user', object: @poll.user, as: :user
end

json.questions do
  json.partial! partial: 'questions/question', collection: @poll.questions, as: :question
end

