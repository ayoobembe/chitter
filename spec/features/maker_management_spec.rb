require 'spec_helper'

feature "Maker signs up" do 

	scenario "with matching password and password confirmation" do 
		expect{sign_up}.to change(Maker, :count).by(1)
		expect(page).to have_content("Welcome, neo@theMatrix.com")
		expect(Maker.first.email).to eq("neo@theMatrix.com")
	end

	scenario "with non-matching password and confirmation" do 
		expect{sign_up('neo@matrix.com',
									'MeIsDaOne!',
									'TrinityDaOne!')}.to change(Maker, :count).by(0)
	end

end

def sign_up(email = "neo@theMatrix.com",
						password = "MeIsDaOne!",
						password_confirmation="MeIsDaOne!")
	visit 'makers/new'
	expect(page.status_code).to eq(200)
	fill_in :email, :with => email
	fill_in :password, :with => password 
	fill_in :password_confirmation, :with => password_confirmation
	click_button "Sign up"
end
