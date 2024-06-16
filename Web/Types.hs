module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types
import IHP.LoginSupport.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data SessionsController = 
    NewSessionAction 
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

instance HasNewSessionUrl User where 
    newSessionUrl _ = "/NewSession"
    -- tells the auth module where to redirect a user in case 
    -- the user tries to access an action that requires login

type instance CurrentUserRecord = User 
-- tells the auth system to user our User type within the login system 


data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction 
    | DeleteUserAction { userId :: !(Id User) }
    | LoginAction 
    deriving (Eq, Show, Data)

data BooksController
    = BooksAction
    | NewBookAction
    | ShowBookAction { bookId :: !(Id Book) }
    | CreateBookAction
    | EditBookAction { bookId :: !(Id Book) }
    | UpdateBookAction { bookId :: !(Id Book) }
    | DeleteBookAction { bookId :: !(Id Book) }
    | DownloadBookAction {bookId :: !(Id Book) }
    deriving (Eq, Show, Data)

data ReadersController
    = ReadersAction
    | NewReaderAction
    | ShowReaderAction 
    | CreateReaderAction
    | EditReaderAction { readerId :: !(Id Reader) }
    | UpdateReaderAction { readerId :: !(Id Reader) }
    | DeleteReaderAction { readerId :: !(Id Reader) }
    deriving (Eq, Show, Data)

data CommentsController
    = CommentsAction
    | NewCommentAction
    | ShowCommentAction { commentId :: !(Id Comment) }
    | CreateCommentAction
    | EditCommentAction { commentId :: !(Id Comment) }
    | UpdateCommentAction { commentId :: !(Id Comment) }
    | DeleteCommentAction { commentId :: !(Id Comment) }
    deriving (Eq, Show, Data)
