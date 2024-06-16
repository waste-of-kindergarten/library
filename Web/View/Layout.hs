module Web.View.Layout (defaultLayout, 
  Html,
  navLayout,
  footerLayout,
  carouselLayout,
  sidenavLayout,
  bookLayout,
  loginLayout,
  registerLayout) where

import IHP.ViewPrelude
import IHP.Environment
import Generated.Types
import IHP.Controller.RequestContext
import Web.Types
import Web.Routes
import Application.Helper.View
import Data.Text(unpack,pack)

defaultLayout :: Html -> Html
defaultLayout inner = [hsx|
<!DOCTYPE html>
<html lang="en">
    <head>
        {metaTags}

        {stylesheets}
        {scripts}

        <title>{pageTitleOrDefault "App"}</title>
    </head>
    <body class="bg-dark text-white">
        <div class="container-fluid mt-0 p-0">
            {renderFlashMessages}
            {inner}
        </div>
    </body>
</html>
|]

-- The 'assetPath' function used below appends a `?v=SOME_VERSION` to the static assets in production
-- This is useful to avoid users having old CSS and JS files in their browser cache once a new version is deployed
-- See https://ihp.digitallyinduced.com/Guide/assets.html for more details

stylesheets :: Html
stylesheets = [hsx|
        <link rel="stylesheet" href={assetPath "/vendor/bootstrap-5.2.1/bootstrap.min.css"}/>
        <link rel="stylesheet" href={assetPath "/vendor/flatpickr.min.css"}/>
        <link rel="stylesheet" href={assetPath "/app.css"}/>
    |]

scripts :: Html
scripts = [hsx|
        {when isDevelopment devScripts}
        <script src={assetPath "/vendor/jquery-3.6.0.slim.min.js"}></script>
        <script src={assetPath "/vendor/timeago.js"}></script>
        <script src={assetPath "/vendor/popper-2.11.6.min.js"}></script>
        <script src={assetPath "/vendor/bootstrap-5.2.1/bootstrap.min.js"}></script>
        <script src={assetPath "/vendor/flatpickr.js"}></script>
        <script src={assetPath "/vendor/morphdom-umd.min.js"}></script>
        <script src={assetPath "/vendor/turbolinks.js"}></script>
        <script src={assetPath "/vendor/turbolinksInstantClick.js"}></script>
        <script src={assetPath "/vendor/turbolinksMorphdom.js"}></script>
        <script src={assetPath "/helpers.js"}></script>
        <script src={assetPath "/ihp-auto-refresh.js"}></script>
        <script src={assetPath "/app.js"}></script>
    |]

devScripts :: Html
devScripts = [hsx|
        <script id="livereload-script" src={assetPath "/livereload.js"} data-ws={liveReloadWebsocketUrl}></script>
    |]

metaTags :: Html
metaTags = [hsx|
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta property="og:title" content="App"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="TODO"/>
    <meta property="og:description" content="TODO"/>
    <link rel="icon" type="image/svg+xml" href="/hlib-slogo.svg">
    {autoRefreshMeta}
|]

navLayout :: [Bool] -> Html 
navLayout selections = 
    [hsx|
    <div style="m-0 p-0">
        <nav class="navbar navbar-expand-lg  navbar-dark bg-dark fixed-top">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbar">
      <a class="navbar-brand" href="#">
        <img src="/hlib-slogo.svg" alt="" width="30" height="24" class="d-inline-block align-text-top">
        &nbsp
        HLib
        </a>
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                {forEachWithIndex selections renderNavItem}
      </ul>
      <button class="d-flex btn btn-outline-primary">
      <a class="nav-link" href="/Login">Login</a>
      </button>
      <!--form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form-->
    </div>
  </div>
</nav>
</div>
|]

renderNavItem :: (Int,Bool) -> Html
renderNavItem (index,isSelected) = let style :: Text = if isSelected then " active" else "" in [hsx|
        <li>
            <a class={"nav-link" <> style } href="#">{navItemLabels !! index}</a>
        </li>
    |]


navItemLabels :: [Text]
navItemLabels = ["Home", "About", "Contact"] 

footerLayout :: Html 
footerLayout = [hsx|
    
    <div class="m-0 p-0">
    <footer class="footer mt-auto py-3 bg-dark text-muted w-100" style="font-size:10px;">
      <hr />
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <ul class="list-unstyled d-flex">
                            <li class="flex-grow-1"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
</svg><a>&nbsp About Author</a></li>
                            <li class="flex-grow-1"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-workspace" viewBox="0 0 16 16">
  <path d="M4 16s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H4Zm4-5.95a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
  <path d="M2 1a2 2 0 0 0-2 2v9.5A1.5 1.5 0 0 0 1.5 14h.653a5.373 5.373 0 0 1 1.066-2H1V3a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v9h-2.219c.554.654.89 1.373 1.066 2h.653a1.5 1.5 0 0 0 1.5-1.5V3a2 2 0 0 0-2-2H2Z"/>
</svg><a>&nbsp Become a Contributor</a></li>
                            <li class="flex-grow-1"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-github" viewBox="0 0 16 16">
  <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z"/>
</svg><a> &nbsp Github</a></li>
                            <li class="flex-grow-1"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
</svg><a> &nbsp Email</a></li>
                        </ul>
                    </div>
                </div>
                <br>
                <div class="text-center">
                    <p class="text-muted">© 2024 Alfred's Website. All rights reserved.</p>
                </div>
            </div>
        </footer>
        </div>
|]

carouselLayout :: Html
carouselLayout = [hsx|
<div id="carouselExampleCaptions" class="carousel slide bg-secondary m-0" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="https://www.haskell.org/img/haskell-logo.svg" class="d-block w-100"  style="width: auto; height: 400px;" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <!--h5>Haskell</h5-->
        <p>Haskell is an advanced, purely functional programming language.</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="https://ihp.digitallyinduced.com/ihp.svg" class="d-block w-100" style="width: auto; height: 400px;"  alt="...">
      <div class="carousel-caption d-none d-md-block">
        <!--h5>Ihp</h5-->
        <p>Ihp is a full-stack framework focused on rapid application development while striving for robust code quality.</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="/hlib-logo.svg" class="d-block w-100" style="width: auto; height: 400px;" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <!--h5>HLib</h5-->
        <p>HLib is an e-book library totally built with IHP framework in Haskell.</p>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
|]

sidenavLayout :: Html 
sidenavLayout = [hsx|
  <div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark m-0" style="height:100%; width: 20%;position:fixed">
    <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
      <img src="/hlib-slogo.svg" style="width:16px;height:16px">
      <span class="fs-4">&nbsp; Navigator</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href={BooksAction} class="nav-link active" aria-current="page">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-door" viewBox="0 0 16 16">
  <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4z"/>
</svg>
          Home
        </a>
      </li>
      <li>
        <a href={BooksAction} class="nav-link text-white">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
</svg>
          Likes
        </a>
      </li>
      
      <li>
        <a href={ShowReaderAction} class="nav-link text-white">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
</svg>
          Profile
        </a>
      </li>

    </ul>
    <hr>
    <div class="dropdown">
      <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
        <img src="https://github.com/mdo.png" alt="" width="32" height="32" class="rounded-circle me-2">
        <strong>{omit}</strong>
      </a>
      <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
        <!--li><a class="dropdown-item" href="#">New project...</a></li>
        <li><a class="dropdown-item" href="#">Settings</a></li-->
        <li><a class="dropdown-item" href={EditUserAction currentUser.id}>Change Password</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item js-delete js-delete-no-confirm" href={DeleteSessionAction}>Logout</a></li>
      </ul>
    </div>
  </div>
|]
  where omit :: Text 
        omit = pack $ if length email > 10 
                then take 18 email <> "*"
                else email
                where email = unpack currentUser.email 


  

bookLayout :: Html -> Html 
bookLayout x = [hsx|
  <div class="row">
    <div class="col-2">
      {sidenavLayout}
      </div>
      <div class="container-fluid p-0 col-10">
        {x}
        </div>
  </div>
|]

loginLayout :: Html -> Html 
loginLayout x = [hsx|
  <div class="row mt-5">
    <div class="offset-4 col-4 card bg-success">
      <img src="hlib-logo.svg" class="img-fluid" alt="logo">
      <div class="card-body">
        <h3 class="card-title" style="text-align:center">Welcome to HLib</h3>
        <div class="card-text">
        { x }
        </div>
      </div>
      </div>
    </div>
|]

registerLayout :: Html -> Html 
registerLayout x = [hsx|
  <div class="row mt-5">
    <div class="offset-4 col-4 card bg-success">
      <img src="hlib-logo.svg" class="img-fluid" alt="logo">
      <div class="card-body">
        <h3 class="card-title" style="text-align:center">Register to Enjoy HLib Resources</h3>
        <div class="card-text">
        { x }
        </div>
      </div>
    </div>
  </div>
|]

