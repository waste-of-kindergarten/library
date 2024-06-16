module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome

instance Controller StaticController where
    action WelcomeAction = 
        case currentUserOrNothing of 
            Just currentUser -> do 
                redirectTo BooksAction
            Nothing -> 
                render WelcomeView
