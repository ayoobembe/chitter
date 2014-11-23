require 'spec_helper'

feature "User adds a new peep" do 
	scenario "when browsing the homepage" do 
		expect(Peep.count).to be (0)
		visit '/'
		add_peep("sunday morning, still on my laptop")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.text).to eq("sunday morning, still on my laptop")
	end

	def add_peep(text)
		within('#new-peep') do 
			fill_in 'text', :with => text
			click_button 'Peep'
		end
	end

end