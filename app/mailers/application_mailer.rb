class ApplicationMailer < ActionMailer::Base
  default from: ENV['SPARKPOST_SMTP_HOST']
  layout 'mailer'
end
