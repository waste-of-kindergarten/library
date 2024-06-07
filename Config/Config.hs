module Config where

import IHP.Prelude
import IHP.Environment
import IHP.FrameworkConfig
import IHP.Mail 

config :: ConfigBuilder
config = do
    -- See https://ihp.digitallyinduced.com/Guide/config.html
    -- for what you can do here
    option $ SMTP 
        { host = "smtp.qq.com"
        , port = 25
        , credentials = Just ("2698531708","reztbfnkwfqzddbh")
        , encryption = Unencrypted 
        }