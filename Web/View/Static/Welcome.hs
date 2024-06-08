module Web.View.Static.Welcome where
import Web.View.Prelude
import Web.View.Layout 

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|

    <div class="container-fluid mt-5 p-0">
        <div class="row">
        { navLayout [True,False,False] }
    </div>

    <div class="row">
            <div class="col-2">
        {sidenavLayout}
        </div>
        <div class="container-fluid col-10 ps-5" style="width:80%">
        <div class="row">
        <div class="col-12">
        { carouselLayout }
        </div>
        <div class="row">
        <div class="col-12 text-white">
            Something here<br><br><br>
            Here 
            </div>
            <div class="col-12">
                {footerLayout}
            </div>
        </div>
        </div>
        </div>
    </div>

    </div>




|]