module Web.Mail.Users.Confirmation where

import IHP.MailPrelude
import Generated.Types


data ConfirmationMail = ConfirmationMail { user :: User }

instance BuildMail ConfirmationMail where
  subject = "Confirm your account"
  to ConfirmationMail { .. } = Address { addressName = Just "Support", addressEmail = user.email }
  from = "2698531708@qq.com"
  html ConfirmationMail { .. } = [hsx|
    Hey, <br>
    Thanks for signing up! Currently we don't need to confirm your email address.
  |] 
    {-
    subject = "Confirm your account"
    to ConfirmationMail { .. } = Address { addressName = Just "Support", addressEmail = user.email }
    from = "2698531708@qq.com"
    html ConfirmationMail { .. } = [hsx|
        Hey {user.userName}, 
        Thanks for signing up! Please confirm your account by following this link: ... 
    |]
    -}
