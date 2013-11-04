Models = Toruzou.module "Models"

Models.endpoint = (path) -> "/api/#{Toruzou.Configuration.api.version}/#{path}"

# TODO to Backbone
Models.displayPropertyName = (model, propertyName) ->
  schema = model.schema
  if schema
    property = schema[propertyName]
    return property.title if property and property.title
  _.str.humanize propertyName

# TODO to Backbone
Models.format = (model, propertyName, value) ->
  schema = model.schema
  if schema
    property = schema[propertyName]
    return property.formatter value if property and property.formatter
  value
