class ExampleMailer < ApplicationMailer
  default from: "awwab.ali@7vals.com"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end

end
