Common = Toruzou.module "Deals.Common"

class Common.FormView extends Toruzou.Common.FormView

  template: "deals/form"
  events:
    "submit form": "save"
    "click .cancel": "cancel"
  schema:
    name:
      editorAttrs:
        placeholder: "Name"
    projectType:
      editorAttrs:
        placeholder: "Project Type"
    category:
      editorAttrs:
        placeholder: "Category"
    organizationId:
      editorAttrs:
        placeholder: "Client Organization"
    contactId:
      editorAttrs:
        placeholder: "Client Person"
    pmId:
      editorAttrs:
        placeholder: "Project Manager"
    salesId:
      editorAttrs:
        placeholder: "Sales Person"
    status:
      editorAttrs:
        placeholder: "Status"
    amount:
      editorAttrs:
        placeholder: "Amount"
    accuracy:
      editorAttrs:
        placeholder: "Accuracy"
    startDate:
      editorAttrs:
        placeholder: "Start Date"
    orderDate:
      editorAttrs:
        placeholder: "Order Date"
    acceptDate:
      editorAttrs:
        placeholder: "Accept Date"

  constructor: (options) ->
    super options
    @title = _.result options, "title"

  serializeData: ->
    data = super
    data["title"] = @title
    data

  save: (e) ->
    e.preventDefault()
    @commit().done (model) -> Toruzou.execute "show:deals:show", model.get "id"
        
  cancel: (e) ->
    e.preventDefault()
    @close()
