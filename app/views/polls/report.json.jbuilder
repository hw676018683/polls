json.(@poll, :id, :title, :description)

json.questions do
  json.array! @poll.questions do |question|
    json.(question, :id, :title)
    json.choices do
      json.array! question.choices do |choice|
        json.(choice, :id, :title, :limit)
        json.select_count choice.user_ids.count
      end
    end
  end
end