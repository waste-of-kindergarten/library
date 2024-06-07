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
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)
