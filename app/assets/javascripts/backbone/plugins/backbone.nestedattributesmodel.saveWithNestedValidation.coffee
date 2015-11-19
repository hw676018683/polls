Backbone.NestedAttributesModel::saveWithNestedValidation = (attributes, options) ->
  hasError = false

  for subModel in @subModels
    hasError = true if !subModel.isValid(options)
    for subsubModel in subModel.subModels
      hasError = true if !subsubModel.isValid(options)

  if @isValid(options) && !hasError
    return @save(attributes, options)
  else
    return false
