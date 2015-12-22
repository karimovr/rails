class NotificationMailer < ApplicationMailer
  def comment_notification(user, post, comment )
    @user = user
    @post = post
    @comment = comment
    mail(to: user.email, subject: 'Новый ответ на ваш пост')
  end

  def subscribe_notification(user, post, comment)
    @user = user
    @post = post
    @comment = comment
    mail( to: user.email, subject: 'Подписка на публикацию')
  end
end
