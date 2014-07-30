class UserMailer < ActionMailer::Base
  default from: "no-reply@elsupersan.com"
  layout 'email'

  def welcome(user)
    @user = user
    @url  = 'http://elsupersan.com/sign_in'
    mail(to: @user.email, subject: 'Bienvenido/a a elSuperSan.com')
  end

  def payment_sent_email(payment)
    @user = payment.login
    @url  = "http://elsupersan.com/payments/#{payment.id}/confirmation"
    mail(to: @user.email, subject: 'Nuevo Pago Recibido - elSuperSan.com')
  end

  def payment_received_email(payment)
    @user = payment.beneficiary
    @payment = payment
    @url  = "http://elsupersan.com/turn_wizard/#{payment.level_id}"
    mail(to: @user.email, subject: 'Tu Pago ha sido Confirmado - elSuperSan.com')
  end

end
