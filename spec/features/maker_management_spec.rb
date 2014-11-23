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
		expect(current_path).to eq('/makers')
		expect(page).to have_content("Password does not match the confirmation")
	end

	scenario "with an email that is already registered" do 
		expect{sign_up}.to change(Maker, :count).by(1)
		expect{sign_up}.to change(Maker, :count).by(0)
		expect(page).to have_content("This email is taken")
	end

end

feature "Maker signs in" do 
	before(:each) do 
		Maker.create(:email => 'test@test.com',
								:password => 'test',
								:password_confirmation => 'test' )
	end

	scenario 'with correct credentials' do 
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'test')
		expect(page).to have_content("Welcome, test@test.com")
	end

	scenario 'with incorrect credentials' do 
		visit '/'
		expect(page).not_to have_content('Welcome, test@test.com')
		sign_in('test@test.com', 'wrong')
		expect(page).not_to have_content('Welcome, test@test.com')
	end
end

feature "Maker signs out" do 
	before(:each) do 
		Maker.create(:email => 'test@test.com',
								:password => 'test',
								:password_confirmation => 'test' )
	end

	scenario "while being signed in" do 
		sign_in('test@test.com','test')
		click_button'Sign out'
		expect(page).not_to have_content("Welcome, test@test.com")
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

def sign_in(email, password)
	visit '/sessions/new'
	fill_in :email, :with => email
	fill_in :password, :with => password 
	click_button 'Sign in'
end