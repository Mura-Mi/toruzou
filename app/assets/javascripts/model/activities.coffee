Model = Toruzou.module "Model"

# TODO Refine validators (character length etc.)

class Model.Activity extends Backbone.Model

  urlRoot: Model.endpoint "activities"
  modelName: "activity"
  actions: [
    "Meeting"
    "Call"
    "Email"
    "Task"
  ]
  icons:
    "Meeting": "briefcase"
    "Email": "envelope"
    "Call": "phone"
    "Task": "ticket"

  defaults:
    name: ""
    action: ""
    date: ""
    note: ""
    done: false
    organization: null
    organizationId: null
    deal: null
    dealId: null
    users: []
    userIds: []
    people: []
    peopleIds: []

  # TODO ugly, should be moved to view layer
  renderIcon: (action) ->
    "<i class='icon-#{Activity::icons[action]} icon-inline-prefix'></i>"
  renderAction: (action) ->
    @renderIcon(action) + _.escape action

  createNote: ->
    note = new Model.Note()
    note.subject = @
    note
    
  schema:
    name:
      type: "Text"
      validators: [ "required" ]
    action:
      type: "Selectize"
      validators: [ "required" ]
      restore: (model) ->
        action = model.get "action"
        {
          value: action
          data: action
        }
      options: @::actions
      selectize:
        render:
          option: (item, escape) => "<div>#{Activity::renderAction item.text}</div>"
    date:
      type: "Datepicker"
      formatter: (value) -> Toruzou.Common.Formatters.localDate value
    organizationId: $.extend true, {},
      Model.Schema.Organization,
      title: "Organization"
      key: "organization"
    organization:
      formatter: (value) -> value?.name
    dealId: $.extend true, {},
      Model.Schema.Deal,
      title: "Deal"
      key: "deal"
    deal:
      formatter: (value) -> value?.name
    usersIds: $.extend true, {},
      Model.Schema.Users,
      title: "Users"
      key: "users"
    users:
      formatter: (value) -> (_.pluck value, "name").join ", "
    peopleIds: $.extend true, {},
      Model.Schema.People,
      title: "Contacts"
      key: "people"
    people:
      formatter: (value) -> (_.pluck value, "name").join ", "
    note:
      title: "Summary"
      type: "TextArea"
    done:
      type: "Checkbox"
    deletedAt:
      title: "Deleted Datetime"
      formatter: (value) -> Toruzou.Common.Formatters.localDatetime value

  attachmentsUrl: ->
    _.result(@, "url") + "/attachments"

  toggleDone: ->
    done = !!!(@get "done")
    @set "done", done
    done


class Model.Activities extends Backbone.PageableCollection

  url: Model.endpoint "activities"
  model: Model.Activity

  state:
    sortKey: "date"
    order: 1
    

API =
  createActivity: (options) ->
    new Model.Activity options
  createActivities: (options) ->
    collection = new Model.Activities()
    _.extend collection.queryParams, options
    collection
  getActivity: (id) ->
    activity = API.createActivity id: id
    activity.fetch()
  getActivities: (options) ->
    collection = API.createActivities options
    collection.fetch()

Toruzou.reqres.setHandler "activity:new", API.createActivity
Toruzou.reqres.setHandler "activities:new", API.createActivities
Toruzou.reqres.setHandler "activity:fetch", API.getActivity
Toruzou.reqres.setHandler "activities:fetch", API.getActivities
