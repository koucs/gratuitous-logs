# -*- coding: utf-8 -*-

require 'rails_helper'

RSpec.describe Category, :type => :model do
    context "when Category create" do
        subject{ Category.all.size }
        before do
            for num in 1..3 do
                create(:category)
            end
        end
        it { should eq(3) }
    end
end
