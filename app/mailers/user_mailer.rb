class UserMailer < ApplicationMailer
	default from: 'support@edificapro.com'

	def welcome_email(user)
		@user = user
		@url = 'http://progrehab.apabcn.cat'
		mail(to: @user.email, subject: 'Benvinguts al web')
	end

end
