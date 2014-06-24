class InvitesController < ApplicationController
	def index
		@contacts = request.env['omnicontacts.contacts']
		# TODO this is very very wrong, needs to go in a asynchronous process
		@contacts.each do |contact|
			current_user.contacts.create(:first_name => contact[:first_name],
																	 :last_name => contact[:last_name],
																	 :email => contact[:email])
		end
		respond_to do |format|
			format.html
		end
	end
end
