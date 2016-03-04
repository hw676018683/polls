json.(@poll, :id, :title, :description, :started_at)
json.writable @poll.writable?

json.user do
  json.partial! partial: 'users/user', object: @poll.user, as: :user
end

json.questions do
  json.partial! partial: 'questions/question', collection: @poll.questions, as: :question
end

