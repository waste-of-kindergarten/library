module Web.Routes where
import IHP.RouterPrelude
import Generated.Types
import Web.Types

-- Generator Marker
instance AutoRoute StaticController

instance AutoRoute SessionsController 
instance AutoRoute UsersController


instance AutoRoute BooksController


instance AutoRoute ReadersController


instance AutoRoute CommentsController

