module Web.View.Readers.Edit where
import Web.View.Prelude

data EditView = EditView { reader :: Reader }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Reader</h1>
        {renderForm reader}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Readers" ReadersAction
                , breadcrumbText "Edit Reader"
                ]

renderForm :: Reader -> Html
renderForm reader = formFor reader [hsx|
    {(textField #userId)}
    {(textField #readerName)}
    {(textField #introduction)}
    {(textField #loves)}
    {submitButton}

|]