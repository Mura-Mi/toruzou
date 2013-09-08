Toruzou.module "Users.SignIn", (SignIn, Toruzou, Backbone, Marionette, $, _) ->

  class SignIn.View extends Toruzou.Common.FormView

    template: "users/sign_in"
    events:
      "submit form": "signIn"
    schema:
      login:
        editorAttrs:
          placeholder: "Your username or email"
      password:
        help: "<a href=\"retrieve_password\" class=\"help\">(Forgot password ?)</a>"
        editorAttrs:
          placeholder: "Your password"

    constructor: ->
      super model: new Toruzou.Models.UserCredential()

    signIn: (e) ->
      e.preventDefault()
      @commit
        success: (model, response) ->
          Toruzou.currentUser = new Toruzou.Models.User response
          Toruzou.trigger "authentication:signedIn"
