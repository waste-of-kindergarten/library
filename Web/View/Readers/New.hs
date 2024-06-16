module Web.View.Readers.New where
import Web.View.Prelude

data NewView = NewView { reader :: Reader }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Reader</h1>
        {renderForm reader}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Readers" ReadersAction
                , breadcrumbText "New Reader"
                ]

renderForm :: Reader -> Html
renderForm reader = formFor reader [hsx|
    {(textField #userId)}
    {(textField #readerName)}
    {(textField #introduction)}
    {(textField #loves)}
    {submitButton}

|]