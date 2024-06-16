module Web.View.Books.Show where
import Web.View.Prelude

{-
Show the information of a book 
-}

data ShowView = ShowView { book :: Book ,readerandcomments :: [(Reader,Comment)]}

instance View ShowView where
    html ShowView { .. } = [hsx|
        {bookLayout (innerLayout book readerandcomments)}
    |]


innerLayout ::  Book -> [(Reader,Comment)] -> Html 
innerLayout bk rcs = [hsx|

    <div class="d-flex" style="background: #49AFD0; height:2px; width: 100%; margin-bottom: 20px;">&nbsp;</div>
    <div class="row">
    <div class="container-fluid p-0 offset-3 col-8">
    <div class="card bg-white" style="width:80%">
    <img src="/default.png" class="card-img-top" alt="">
    <div class="card-body">
    <h2 class="card-title bg-white text-dark" style="text-align:center">
    {bk.bookName}
    </h2>
    <div class="card-text">
    <ul class="list-group list-group-flush">
        <li class="list-group-item">author: &nbsp; {bk.author}</li>
        <li class="list-group-item">category: &nbsp; {bk.category}</li>
        <li class="list-group-item">publicationYear: &nbsp; {bk.publicationYear}</li>
        <li class="list-group-item">press: &nbsp; {bk.press}</li>
        <li class="list-group-item">tags: 
            {forEach bk.tags renderTag}
            </li>
        <li class="list-group-item">size: &nbsp; {bk.size} MB </li>
    </ul>
    </div>
    </div>
    <a href={DownloadBookAction bk.id} class="btn btn-primary" download>Download pdf</a>
    </div>
    </div>
    </div>
    <div class="d-flex" style="background: #49AFD0; height:2px; width: 100%; margin-bottom: 20px; margin-top: 20px">&nbsp;</div>
    <br>
        <h4 class="container-fluid offset-1">Comments</h4>
        <div class="d-flex" style="background: #49AFD0; height:2px; width: 100%; margin-bottom: 20px; margin-top: 20px">&nbsp;</div>
    <div class="container-fluid offset-3 col-8">
    <div>{forEach rcs renderComment}</div>
    <br><br>
    </div>

|] 

renderComment :: (Reader,Comment) -> Html 
renderComment rc = [hsx|
    <div class="card bg-white" style="width:80%">
        <div class="card_body">
            <h4 class="card-title bg-white text-primary">
                {name}
            </h4>
            <div class="card-text bg-white text-dark">
                {content}
            </div>
        </div>
    </div>
|]
    where name = (fst rc).readerName 
          content = (snd rc).comment 

renderTag :: Text -> Html 
renderTag x = [hsx| 
    &nbsp; <a href="">{ x } </a>
|]



