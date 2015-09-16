Backbone.Model::deepToJSON = () ->
  object = _.clone(this.attributes)

  for attr, value of object
    object[attr] = if value.toJSON
                      value.toJSON()
                    else
                      value
  object

