Models = Toruzou.module "Models"

Models.Attachment = class Attachment extends Backbone.Model

  urlRoot: Models.endpoint "attachments"


Models.Attachments = class Attachments extends Backbone.PageableCollection

  url: Models.endpoint "attachments"
  model: Models.Attachment

  state:
    sortKey: "updated_at"
    order: 1


API =
  getAttachments: (options) ->
    attachments = new Models.Attachments()
    _.extend attachments.queryParams, options
    dfd = $.Deferred()
    attachments.fetch success: (collection) -> dfd.resolve collection
    dfd.promise()

Toruzou.reqres.setHandler "attachments:fetch", (options) -> API.getAttachments options
