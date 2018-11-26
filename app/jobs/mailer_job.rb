class MailerJob

  attr_accessor :reservation

  def initialize(params)
    @reservation = params[:reservation]
  end

  def perform
    ConfirmationMailer.with(reservation: @reservation).reminder_email.deliver
  end
end
