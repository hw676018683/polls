json.(question, :id, :title, :multiple)

json.choices do
  json.partial! partial: 'choices/choice', collection: question.choices, as: :choice
end
