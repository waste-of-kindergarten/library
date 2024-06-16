module Web.Controller.Books where

import Web.Controller.Prelude
import Web.View.Books.Index
import Web.View.Books.New
import Web.View.Books.Edit
import Web.View.Books.Show
import BasicPrelude (readFile, encodeUtf8, Show (show),print)
import Network.HTTP.Types.Status (status200)
import Network.Wai.Internal 
import System.Directory (getFileSize)
import Data.Text(unpack)
import ClassyPrelude (Traversable(..))



instance Controller BooksController where
    action BooksAction = do
        books <- query @Book |> fetch
        render IndexView { .. }

    action NewBookAction = do
        let book = newRecord
        render NewView { .. }

    action ShowBookAction { bookId } = do
        book <- fetch bookId
        comments <- query @Comment 
            |> filterWhere (#bookId,book.id)
            |> fetch 
        readers <- mapM (\cm -> do 
                        query @Reader 
                            |> filterWhere (#id,cm.readerId)
                            |> fetchOne) comments 
        let res = zip readers comments
        print res 
            -- |> mapM (\x -> x >>= fetchRelated #readers)  
        render ShowView { book = book , readerandcomments = res}


    action EditBookAction { bookId } = do
        book <- fetch bookId
        render EditView { .. }

    action UpdateBookAction { bookId } = do
        book <- fetch bookId
        book
            |> buildBook
            |> ifValid \case
                Left book -> render EditView { .. }
                Right book -> do
                    book <- book |> updateRecord
                    setSuccessMessage "Book updated"
                    redirectTo EditBookAction { .. }

    action CreateBookAction = do
        let book = newRecord @Book
        book
            |> buildBook
            |> ifValid \case
                Left book -> render NewView { .. } 
                Right book -> do
                    book <- book |> createRecord
                    setSuccessMessage "Book created"
                    redirectTo BooksAction

    action DeleteBookAction { bookId } = do
        book <- fetch bookId
        deleteRecord book
        setSuccessMessage "Book deleted"
        redirectTo BooksAction

    action DownloadBookAction { bookId } = do 
        book <- fetch bookId 
        --bookContent <- liftIO $ readFile ("resource/" <> show bookId)
        respondAndExit (ResponseFile 
            status200 
            [("Content-Type","application/pdf"),
            ("Content-Disposition","attachment; filename=\"" <> encodeUtf8 book.bookName <> ".pdf\"")
            ]
            ("resource/books/" <> unpack book.bookName <> ".pdf") Nothing)

 
                

buildBook book = book
    |> fill @'["bookName", "author", "category", "publicationYear", "press", "tags","size"]
