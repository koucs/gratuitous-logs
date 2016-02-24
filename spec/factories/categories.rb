# -*- coding: utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence(:name){|n| "Test Category #{n}" }
    sequence(:description){|n| "Test Description #{n}" }
    # Cloudinary Test Image
    image_url "http://res.cloudinary.com/hhokqdeq5/image/upload/v1439257517/Other_y9rpps.jpg"
  end

end
