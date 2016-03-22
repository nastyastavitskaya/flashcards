class ApplicationMailer < ActionMailer::Base
  default from: "smtp.sparkpostmail.com"
  layout "mailer"
end
