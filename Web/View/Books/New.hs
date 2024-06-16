module Web.View.Books.New where
import Web.View.Prelude

data NewView = NewView { book :: Book }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Book</h1>
        {renderForm book}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Books" BooksAction
                , breadcrumbText "New Book"
                ]

renderForm :: Book -> Html
renderForm book = formFor book [hsx|
    {(textField #bookName)}
    {(textField #author)}
    {(textField #category)}
    {(textField #publicationYear)}
    {(textField #press)}
    {(textField #tags)}
    {(textField #size)}
    {submitButton}

|]