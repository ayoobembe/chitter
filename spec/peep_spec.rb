require 'spec_helper'

describe Peep do 

	context 'Basic function of peeps' do 

		it 'should be created and retrievable from database' do 
			expect(Peep.count).to eq(0)
			Peep.create(:text => "working on my chitter")
			expect(Peep.count).to eq(1)
			peep = Peep.first
			expect(peep.text).to eq("working on my chitter")
			peep.destroy
			expect(Peep.count).to eq(0)
		end

	end

end