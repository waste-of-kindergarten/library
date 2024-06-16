module Web.View.Readers.Index where
import Web.View.Prelude

data IndexView = IndexView { readers :: [Reader] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewReaderAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Reader</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach readers renderReader}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Readers" ReadersAction
                ]

renderReader :: Reader -> Html
renderReader reader = [hsx|
    <tr>
        <td>{reader}</td>
        <td><a href={ShowReaderAction}>Show</a></td>
        <td><a href={EditReaderAction reader.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteReaderAction reader.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]