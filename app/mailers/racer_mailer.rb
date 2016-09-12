class RacerMailer < ApplicationMailer
  default from: "registracije@xczld.info"

  def welcome_email(racer)
    @racer = racer
    mail(to: @racer.email, subject: 'Registracija za MTB ligu Dalmacije')
  end
end
