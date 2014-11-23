require 'spec_helper'

feature 'User browses list of peeps' do 
	
	before(:each) {
		Peep.create(:text => "working on my chitter")
	}

	scenario "when visiting page" do 
		visit '/'
		expect(page).to have_content("working on my chitter")
	end


end