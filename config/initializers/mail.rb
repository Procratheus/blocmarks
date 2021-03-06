ActionMailer::Base.smtp_settings = {
  port:             587,
  address:          "smtp.mailgun.org",
  user_name:        ENV["MAILGUN_SMTP_LOGIN"],
  password:         ENV["MAILGUN_SMTP_PASSWORD"],
  domain:           "https://api.mailgun.net/v3/app127bf308dc9b441d85d03d06048c322e.mailgun.org",
  authentication:   :plain,
  content_type:     "text/html"
}

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.raise_delivery_errors = true

class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to = "alex.lewis79@yahoo.co.uk"
    message.cc = nil
    message.bcc = nil
  end
end

if Rails.env.development?
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end