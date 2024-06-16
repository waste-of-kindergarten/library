module Web.View.Readers.Show where
import Web.View.Prelude


data ShowView = ShowView { reader :: Reader }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {bookLayout (innerLayout reader)}
    |]

innerLayout :: Reader -> Html 
innerLayout rd = [hsx|
    <div class="d-flex" style="background: #49AFD0; height:2px; width: 100%; margin-bottom: 20px;">&nbsp;</div>
    <div class="row">
    <div class="container-fluid p-0 offset-3 col-8">
        <div class="card bg-white text-dark" style="width:80%">
        
            <img src="default.png" class="card-img-top" alt="">
            <div class="card-body">
                <h2 class="card-title bg-white text-dark" style="text-align:center">Profile</h2>
                <div class="card-text">
                    {renderForm rd}
                </div>
           
        </div>
        </div>
    </div>
    </div>
    <div class="d-flex" style="background: #49AFD0; height:2px; width: 100%; margin-bottom: 20px; margin-top: 20px">&nbsp;</div>
|]

renderForm :: Reader -> Html 
renderForm rd = [hsx|
    <form method="POST" action={UpdateReaderAction rd.id} id="reader_change" class="new-form" data-disable-javascript-submission="false">
        <div class="mb-3" id="form-group-reader_name">
        <label class="form-label" for="reader_name">Name</label>
        <input type="text" name="name" placeholder="" id="reader_name" class="form-control" value={rd.readerName}  required="required" readonly> 
    </div> 
    <div class="mb-3" id="form-group-user_introduction">
        <label class="form-label" for="reader_introduction">Introduction</label>
        <input type="text" name="introduction" placeholder="" id="reader_introduction" class="form-control" value={rd.introduction} readonly> 
    </div>
    <div class="row">
    <div class="col-6"><button class="btn btn-success" type="button" style="width:100%" onclick="enableEditing()">Change</button></div>
    <div class="col-6"><button class="btn btn-primary" type="submit" style="width:100%">Submit</button></div>
    </div>
    </form> 
    <script>
        function enableEditing() {
        alert("you can change your profile new !")
        document.getElementById('reader_name').readOnly = false;
        document.getElementById('reader_introduction').readOnly = false;
    }
    </script>
|]