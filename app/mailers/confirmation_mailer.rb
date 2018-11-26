class ConfirmationMailer < ApplicationMailer
  default from: 'hotel@inzynierka.pl'

  def confirmation_email
    @reservation = params[:reservation]
    @user = @reservation.user
    @url = 'http://localhost:3500/reservations'
    mail(to: @user.email, subject: 'Reservation confirmation')
  end

  def delete_confirmation_email
    @reservation = params[:reservation]
    @user = @reservation.user
    mail(to: 'administrator_hotelu@inzynierka.pl', subject: 'Cancelled reservation')
  end

  def reminder_email
    @reservation = params[:reservation]
    @user = @reservation.user
    mail(to: @user.email, subject: 'Reminder')
  end
end
