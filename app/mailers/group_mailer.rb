class GroupMailer < ApplicationMailer

  def event_email(users, title, content)
    @content = content
    @title = title
    mail(cc: users.pluck(:email), subject: @title)
  end
end
