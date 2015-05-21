class ChargesController < ApplicationController

def new
	#amount in cents
	@amount = 1500

	@stripe_btn_data = {
		key: "#{ Rails.configuration.stripe[:publishable_key] }",
		description: "Blocipedia Premium Membership - #{current_user.username}",
		amount: @amount
	}
end

def create
	#amount in cents
	@amount = 1500
	# Creates a Stripe Customer object, for association with the charge
	customer = Stripe::Customer.create(
		email: current_user.email,
		card: params[:stripeToken]
		)

	# Where the real magic happens
	charge = Stripe::Charge.create(
		customer: customer.id, # Note -- this is not the user_id
		amount:  @amount,
		description: "Blocipedia Premium Membership - #{current_user.email}",
		currency: 'aud'
		)

	current_user.update_attribute(:role, 'premium')
	flash[:notice] = "Successful payment, #{current_user.username}. You are now a Premium user. Thanks!"
	redirect_to user_path(current_user)

	# Stripe error messages
	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_charge_path
end

def destroy
	current_user.update_attribute(:role, nil)
	@wikis = current_user.wikis
	@wikis.update_all(private: false)
	flash[:notice] = "Successfully downgraded to basic"
	redirect_to user_path(current_user)
end

end