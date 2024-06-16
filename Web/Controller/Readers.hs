module Web.Controller.Readers where

import Web.Controller.Prelude
import Web.View.Readers.Index
import Web.View.Readers.New
import Web.View.Readers.Edit
import Web.View.Readers.Show

instance Controller ReadersController where
    action ReadersAction = do
        readers <- query @Reader |> fetch
        render IndexView { .. }

    action NewReaderAction = do
        let reader = newRecord
        render NewView { .. }

    action ShowReaderAction = do
        reader <- query @Reader 
            |> filterWhere (#userId,currentUser.id)
            |> fetchOne
        render ShowView { .. }

    action EditReaderAction { readerId } = do
        reader <- fetch readerId
        render EditView { .. }

    action UpdateReaderAction { readerId } = do
        reader <- fetch readerId
        reader
            |> buildReader
            |> ifValid \case
                Left reader -> render EditView { .. }
                Right reader -> do
                    reader <- reader |> updateRecord
                    setSuccessMessage "Reader updated"
                    redirectTo EditReaderAction { .. }

    action CreateReaderAction = do
        let reader = newRecord @Reader
        reader
            |> buildReader
            |> ifValid \case
                Left reader -> render NewView { .. } 
                Right reader -> do
                    reader <- reader |> createRecord
                    setSuccessMessage "Reader created"
                    redirectTo ReadersAction

    action DeleteReaderAction { readerId } = do
        reader <- fetch readerId
        deleteRecord reader
        setSuccessMessage "Reader deleted"
        redirectTo ReadersAction

buildReader reader = reader
    |> fill @'["userId", "readerName", "introduction", "loves"]
