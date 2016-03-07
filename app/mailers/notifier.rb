class Notifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_friend.subject
  #
  def email_friend(ary, note=nil)
    @ary = ary
    @note = note

    mail to: "guneybilen@yahoo.com", subject: "Good News"
  end
  
  def email_bad_news(sorry)
    @sorry = sorry
    
    mail to: "guneybilen@yahoo.com", subject: "Bad News"
  end
end
