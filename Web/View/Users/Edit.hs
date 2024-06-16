module Web.View.Users.Edit where
import Web.View.Prelude

data EditView = EditView 

instance View EditView where
    html EditView = [hsx|
        <div class="row mt-5">
    <div class="offset-4 col-4 card bg-success">
      <img src="hlib-logo.svg" class="img-fluid" alt="logo">
      <div class="card-body">
        <h3 class="card-title" style="text-align:center">Change Password</h3>
        <div class="card-text">
        {renderForm'}
        </div>
      </div>
    </div>
  </div>
    |]



renderForm' :: Html
renderForm' =  [hsx|
    <form method="POST" action={UpdateUserAction} id="" class="edit-form" data-disable-javascript-submission="false">
        <div class="mb-3" id="form-group-user_email">
            <input type="hidden" name="email" placeholder="" id="user_email" class="form-control" disabled="disabled" value={currentUser.email}>
        </div> 
        <div class="mb-3" id="form-group-user_passwordHash">
            <label class="form-label" for="user_passwordHash">New Password</label>
            <input type="password" name="passwordHash" placeholder="" id="user_passwordHash" class="form-control" value="" required="required"> 
        </div> 
        <div class="mb-3" id="form-group-user_passwordHash">
            <label class="form-label" for="user_passwordHash">New Password Confirmation</label>
            <input type="password" name="passwordConfirmation" placeholder="" id="user_passwordHash" class="form-control" value="" required="required"> 
        </div>
        <div style="text-align:center"><button class="btn btn-primary" type="submit" style="width:100%">Change</button></div></form>
|]

    