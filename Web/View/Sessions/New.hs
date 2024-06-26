module Web.View.Sessions.New where
import Web.View.Prelude
import IHP.AuthSupport.View.Sessions.New
import Web.View.Layout 

instance View (NewView User) where
    html NewView { .. } =  [hsx|
        {loginLayout renderForm}
    |]


renderForm ::  Html 
renderForm  = [hsx|
<form method="POST" action={CreateSessionAction} id="session_new" class="new-form" data-disable-javascript-submission="false">
    <div class="mb-3" id="form-group-user_email">
        <label class="form-label" for="user_email">Email</label>
        <input type="text" name="email" placeholder="" id="user_email" class="form-control"> 
    </div> 
    <div class="mb-3" id="form-group-user_passwordHash">
        <label class="form-label" for="user_passwordHash">Password</label>
        <input type="password" name="password" placeholder="" id="user_passwordHash" class="form-control" required="required"> 
    </div>
    forget password ?
    <div style="text-align:center"><button class="btn btn-primary" type="submit" style="width:100%">Login</button></div>
</form>
|]
