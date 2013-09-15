Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  # TODO Refine validators (character length etc.)

  Models.Activity = class Activity extends Backbone.Model

    urlRoot: Models.endpoint "activities"
    modelName: "activity"
    icons:
      "Meeting": "briefcase"
      "Email": "envelope"
      "Call": "phone"
      "Task": "check"

    defaults:
      subject: ""
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
    renderAction: (action) ->
      "<i class='icon-#{Activity::icons[action]} icon-inline-prefix'></i>#{_.escape action}"

    schema:
      subject:
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
        options:
          [
            "Meeting"
            "Call"
            "Email"
            "Task"
          ]
        selectize:
          render:
            option: (item, escape) => "<div>#{Activity::renderAction item.text}</div>"
      date:
        type: "Datepicker"
      organizationId: $.extend true, {},
        Models.Schema.Organization,
        title: "Organization"
        key: "organization"
      dealId: $.extend true, {},
        Models.Schema.Deal,
        title: "Deal"
        key: "deal"
      usersIds: $.extend true, {},
        Models.Schema.Users,
        title: "Users"
        key: "users"
      peopleIds: $.extend true, {},
        Models.Schema.People,
        title: "Contacts"
        key: "people"
      note:
        type: "TextArea"
      done:
        type: "Checkbox"


  Models.Activities = class Activity extends Backbone.PageableCollection

    url: Models.endpoint "activities"
    model: Models.Activity


  API =
    getActivities: (options) ->
      activities = new Models.Activities()
      _.extend activities.queryParams, options
      dfd = $.Deferred()
      activities.fetch success: (collection) -> dfd.resolve collection
      dfd.promise()
    getActivity: (id) ->
      activity = new Models.Activity id: id
      dfd = $.Deferred()
      activity.fetch
        success: (model) -> dfd.resolve model
        error: (model) -> dfd.resolve undefined
      dfd.promise()

  Toruzou.reqres.setHandler "activities:fetch", (options) -> API.getActivities options
  Toruzou.reqres.setHandler "activity:fetch", (id) -> API.getActivity id