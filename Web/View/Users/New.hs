module Web.View.Users.New where
import Web.View.Prelude

data NewView = NewView { user :: User }

instance View NewView where
    html NewView { .. } = [hsx|
        {registerLayout (renderForm user)}
    |]


renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(textField #email)}
    {(passwordField #passwordHash) {fieldLabel = "Password", required = True}}
    {(passwordField #passwordHash) {fieldLabel = "Password Confirmation", required = True, fieldName = "passwordConfirmation", validatorResult = Nothing}}
    <div style="text-align:center"><button class="btn btn-primary" type="submit" style="width:100%">Register</button></div>
|]